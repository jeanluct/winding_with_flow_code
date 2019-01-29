#include <iostream>
#include <cmath>
#include "mex.h"
using namespace std;

extern void _main();

double winding_angle(double T, double r0, double D, double C, double dt_min)
{
    double t = 0;
    mwSize n = 10000;
    double winding_per_step = .1/2/D;
    double theta = 0;
    double x0 = r0, x1, x2;
    double y0 = 0, y1, y2;
    double dx, dy;
    int wind_p = 0;
    int wind_m = 0;

    const mwSize dim[2] = {1,n};

    mxArray *xA = mxCreateNumericArray(2,dim,mxDOUBLE_CLASS,mxREAL); //I use xA,yA to store the path point, it did help debug, but is not needed for computing winding angle. I keep it just in case the need of future debugging.
    mxArray *yA = mxCreateNumericArray(2,dim,mxDOUBLE_CLASS,mxREAL);
    double *x = mxGetPr(xA), *y = mxGetPr(yA);

    mxArray *x_incrementA, *y_incrementA, *prhs2[2];
    double *x_increment, *y_increment;

    prhs2[0] = mxCreateDoubleScalar(1);
    prhs2[1] = mxCreateDoubleScalar(n-1);

    for(int m=0;t<T&&m<100;m++)
    {
        //call MATLAB funtion to generate displacement

        //execute MATLAB "x = randn(1,n-1)"
        mexCallMATLAB(1,&x_incrementA,2,prhs2,"randn");
        x_increment = mxGetPr(x_incrementA);

        //execute MATLAB "y_increment = randn(1,n-1)"
        mexCallMATLAB(1,&y_incrementA,2,prhs2,"randn");
        y_increment = mxGetPr(y_incrementA);


        x[0] = x0;
        y[0] = y0;

        for (int i = 0; i < n-1; i++)
        {
            double dt;
            //dt = winding_per_step*(x0*x0 + y0*y0);
            dt = max(dt_min,min(1.,winding_per_step*(x0*x0 + y0*y0)));
            //dt = .001;
            t = t + dt;
            dx = x_increment[i]*sqrt(2*D*dt);
            dy = y_increment[i]*sqrt(2*D*dt);
            x1 = x0 + dx - C*y0*dt/(x0*x0+y0*y0);
            y1 = y0 + dy + C*x0*dt/(x0*x0+y0*y0);

            if(y0>=0 && y1<0)
                if( x0*y1 - x1*y0 < 0)
                    wind_m++;
            if(y0<0 && y1>0)
                if( x0*y1 - x1*y0 > 0)
                    wind_p++;

            x[i+1] = x0 = x1;
            y[i+1] = y0 = y1;
        }
    }

    if(t<T)
        cout<<"r = "<< sqrt(x0*x0+y0*y0)<<endl;

    theta = atan2(y0,x0);
    if(theta<0) theta += 2*M_PI;
    theta = theta + (wind_p - wind_m)*2*M_PI;

    mxDestroyArray(xA);
    mxDestroyArray(yA);
    mxDestroyArray(x_incrementA);
    mxDestroyArray(y_incrementA);
    mxDestroyArray(prhs2[0]);
    mxDestroyArray(prhs2[1]);

    return theta;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	//X = Brownian_pt_drift_nut_helper(M,T,r0,D,C,dt)

    const mwSize M = (mwSize) mxGetScalar(prhs[0]);
    const double T =  mxGetScalar(prhs[1]);
    const double r0 = mxGetScalar(prhs[2]);
    const double D =  mxGetScalar(prhs[3]);
    const double C =  mxGetScalar(prhs[4]);
    const double dt_min =  mxGetScalar(prhs[5]);

    const mwSize dim[2] = {1,M};
	plhs[0] = mxCreateNumericArray(2,dim,mxDOUBLE_CLASS,mxREAL);
	double *X = mxGetPr(plhs[0]);

	for(int i = 0; i < M; i++) X[i] = winding_angle(T,r0,D,C,dt_min);

}
