# skylineR 
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")
> __R wrapper for small molecule SRM-MS integration using _Skyline___

To download the source;
```sh
git clone https://github/com/wilsontom/skylineR
```
Before building and installing you need to make sure the `SkylineRunner.exe` is in the `inst` directory and you need to create and empty directory named 'temp' inside the `vignette` directory. 

You also need to make sure you have a full working installation of [Skyline](https://skyline.ms/wiki/home/software/Skyline/page.view?name=default)

You can then build the package;

```sh
R CMD build skylineR_0.1.0
```
and then install;

```sh
R CMD install skyline_0.1.0.tar.gz
```

To view the `vignette`in R console;

```R
vignette('skylineR-vignette',package = 'skylineR')
```
