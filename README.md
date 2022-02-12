# Neutralizing-Breadth

## Requirements
R packages: lsei, xlsx, tidyverse, readxl

Set up excel input files as shown in ExampleINPUT.xlsx file. Sheets should be named "Sheet1" and "Sheet2". 

Sheet1 should include corresponding ranks. Strain names should be in the first (A) column under "strain". bNAbs names should be in the first row.

Sheet2 should include experimental data from each sample needed to be tested. Strains in Sheet2 need to match the strains in Sheet1, otherwise there will be an error.

## Usage

Open Deconvolution.R in R.

Make sure input files are in the correct format and location (ie. change file location to where DeconvInput.xlsx is).

Output file should include pearson correlation values and p-values. 

## License
[GNU AGPLv3](https://choosealicense.com/licenses/agpl-3.0/)
