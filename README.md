This repository contains Matlab and C++ code for the article [_Winding of a Brownian particle around a point vortex_][1] by Huanyu Wen and [Jean-Luc Thiffeault][2].

## Installation

The C++ files are MEX files that will be compiled by Matlab as needed.  Your system must be configured to use a [compatible compiler][3].

## Running the code

From Matlab, run
```
generateFigures_all
```
to create all figures used in [the paper][1].  This can take about 20 minutes, depending on the speed of your computer.

The figures are stored in the subfolder `figs/`, and the data is stored in `data/`.  After the data is generated, set `reRun = false` in `generateFigures_all` if you only wish to recreate the figures.

## License

This code is released under the [GNU General Public License v3][4].  See [COPYING](/COPYING/) and [LICENSE](/LICENSE/).

[1]: https://arxiv.org/abs/1810.13364
[2]: http://www.math.wisc.edu/~jeanluc/
[3]: https://www.mathworks.com/help/matlab/matlab_external/what-you-need-to-build-mex-files.html
[4]: http://www.gnu.org/licenses/gpl-3.0.html
