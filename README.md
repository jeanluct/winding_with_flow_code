This repository contains Matlab and C++ code for the article [_Winding of a Brownian particle around a point vortex_][1] by Huanyu Wen and [Jean-Luc Thiffeault][2].

The C++ files are MEX files that must be compiled within Matlab using
```
>> mex Brownian_annulus_drift_helper.cpp
>> mex Brownian_pt_drift_nut_helper.cpp
>> mex Brownian_inner_disk_helper.cpp
```

[1]: http://arxiv.org/abs/1810.13364
[2]: http://www.math.wisc.edu/~jeanluc/
