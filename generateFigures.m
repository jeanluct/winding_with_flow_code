function generateFigures(figureName, reRun)

	if nargin < 2, reRun = false; end

	dataFile = sprintf('data/%s.mat', figureName);

	if regexp(figureName, regexptranslate('wildcard','inner_disk_correction*'))
		plotFunction	= 'inner_disk_correction_plot';
		index		= strsplit(figureName,'inner_disk_correction');
		index		= index{2};
		switch index
			case '1'
				temp = num2cell([4,2,1,1,0,1e2,1e4]);
			case '2'
				temp = num2cell([4,2,1,1,0,1e4,1e4]);
			case '3'
				temp = num2cell([4,2,1,1,0,1e6,1e4]);
			otherwise
				error('%s not recognized', figureName);
				return
		end
		[r0,ra,dt,D,C,T,M] = temp{:};
		if reRun == true
			X = zeros(M,1);
			for i = 1:M-1
				X(i) = Brownian_inner_disk_helper(1,T,r0,ra,D,C,dt);
			end
			save(dataFile);
		else
			load(dataFile);
		end

	elseif regexp(figureName, regexptranslate('wildcard','inner_disk*'))
		plotFunction	= 'Brownian_inner_disk_plot';
		index 			= strsplit(figureName,'inner_disk');
		index			= index{2};
		switch index
			case '1'
				temp = num2cell([2,0.1,0.01,1,3,1e3,1e4]);
			case '2'
				temp = num2cell([2,0.1,0.01,1,3,1e5,1e4]);
			case '3'
				temp = num2cell([2,0.1,0.01,1,3,1e7,1e4]);
			case '4'
				temp = num2cell([2,0.1,0.001,1,3,1e3,1e4]);
			case '5'
				temp = num2cell([2,0.1,0.001,1,3,1e5,1e4]);
			case '6'
				temp = num2cell([2,0.1,0.001,1,3,1e7,1e4]);
			otherwise
				error('%s not recognized', figureName);
				return
		end
		[r0,ra,dt,D,C,T,M] = temp{:};
		if reRun == true
			X = zeros(M,1);
			for i = 1:M-1
				X(i) = Brownian_inner_disk_helper(1,T,r0,ra,D,C,dt);
			end
			save(dataFile);
		else
			load(dataFile);
		end

	elseif regexp(figureName, regexptranslate('wildcard','annulus_drift*'))
		plotFunction	= 'Brownian_annulus_drift_plot';
		index 			= strsplit(figureName,'annulus_drift');
		index			= index{2};
		switch index
			case '1'
				temp = num2cell([1,0.5,2,0.1,1,1,10,1e5,1e3]);
			case '2'
				temp = num2cell([1,0.5,2,0.1,1,1,100,1e5,1e3]);
			case '3'
				temp = num2cell([1,0.5,2,0.01,1,1,10,1e5,1e3]);
			case '4'
				temp = num2cell([1,0.5,2,0.01,1,1,100,1e5,1e3]);
			otherwise
				error('%s not recognized', figureName);
				return
		end
		[r0,ra,rb,dt,D,C,T,M,k] = temp{:};
		if reRun == true
			l = floor(M/k);
			X = zeros(M,1);
			for i = 0:l-1
				X(i*k+1:(i+1)*k,1) = Brownian_annulus_drift_helper(k,T,r0,ra,rb,D,C,dt);
			end
			save(dataFile);
		else
			load(dataFile);
		end

	elseif regexp(figureName, regexptranslate('wildcard','pt_drift*'))
		plotFunction	= 'Brownian_pt_drift_plot';
		index 			= strsplit(figureName,'pt_drift');
		index			= index{2};
		switch index
			case '1'
				temp = num2cell([1,1,1,1e-30,1e2,1e5,1e3]);
			case '2'
				temp = num2cell([1,1,1,1e-30,1e3,1e5,1e3]);
			case '3'
				temp = num2cell([1,1,1,0.1,1e4,1e5,1e3]);
			case '4'
				temp = num2cell([1,1,1,1e-10,1e4,1e5,1e3]);
			case '5'
				temp = num2cell([1,1,1,1e-20,1e4,1e5,1e3]);
			case '6'
				temp = num2cell([1,1,1,1e-30,1e4,1e5,1e3]);
			otherwise
				error('%s not recognized', figureName);
				return
		end
		[r0,D,C,dt,T,M,k] = temp{:};
		if reRun == true
			l = floor(M/k);
			X = zeros(M,1);
			for i = 0:l-1
				X(i*k+1:(i+1)*k,1) = Brownian_pt_drift_nut_helper(k,T,r0,D,C,dt);
			end
			save(dataFile);
		else
			load(dataFile);
		end

	elseif regexp(figureName, regexptranslate('wildcard','pt_correction*'))
		plotFunction	= 'pt_correction_plot';
		index 			= strsplit(figureName,'pt_correction');
		index			= index{2};
		switch index
			case '1'
				temp = num2cell([1,1,0,1e-10,1e1,1e5,1e3]);
			case '2'
				temp = num2cell([1,1,0,1e-10,1e3,1e5,1e3]);
			case '3'
				temp = num2cell([1,1,0,1e-10,1e5,1e5,1e3]);
			otherwise
				error('%s not recognized', figureName);
				return
		end
		[r0,D,C,dt,T,M,k] = temp{:};
		if reRun == true
			l = floor(M/k);
			X = zeros(M,1);
			for i = 0:l-1
				X(i*k+1:(i+1)*k,1) = Brownian_pt_drift_nut_helper(k,T,r0,D,C,dt);
			end
			save(dataFile);
		else
			load(dataFile);
		end
	else
		error('Unknown figure %s',figureName)
	end

	eval(plotFunction);
	figureFile = sprintf('figs/%s.pdf', figureName);
	hgexport(f,figureFile,hgexport('factorystyle'), 'Format', 'pdf');

end
