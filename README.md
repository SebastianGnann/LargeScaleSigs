# Large scale evaluation of relationships between hydrological signatures and processes
This repository contains code for analysis and visualisation of hydrological signatures using various CAMELS datasets and CZO data.

- workflow_CalculateSignatures.m loads the (pre-processed) data and calculates hydrological signatures with the TOSSH toolbox.
- workflow_AnalyseSignatures.m analyses the signatures and plots the results.
- workflow_InspectSignaturePlots.m inspects signature plots for individual countries or watersheds to check whether the signature calculations are meaningful.
- workflow_CalculateQuantiles.m calculates inverse quantiles of CZO signature values given the CAMELS signatures.
- workflow_PlotMaps.m plots maps of aridity and various signatures for the CAMELS countries.
- workflow_CZO_TOSSH.m calculates the signatures for the critical zone observatories (CZOs).

Large_Scale_Signatures_CZO_Analysis.xlsx contains signature values, percentiles, descriptions of each process and key references for each CZO watershed.

Code to load CAMELS data and save it to a struct file can be found here: https://github.com/SebastianGnann/CAMELS_Matlab

The BrewerMap package used for visualisation can be found here: https://github.com/DrosteEffect/BrewerMap

The TOSSH toolbox used to calculate hydrological signatures can be found here: https://github.com/TOSSHtoolbox/TOSSH