Data integration pipeline, analytical codes and data visualisation for mitotic stopwatch live-cell imaging experiments described in:

Soares-de-Oliveira et al. (2026) Microtubule occupancy at kinetochores links checkpoint silencing with mitotic memory 

bioRxiv preprint: https://doi.org/10.64898/2026.01.26.701783 

Goal of the pipeline is to integrate cell family tracking, mitotic outcomes and daughter cell fates from long-term microscopy assays, where mitosis is delayed by one mean or another (e.g. monastrol treatment + washout). 

How to use this repository:

Download and install relevant python packages
- jupyter
- pandas
- numpy
- altair

Download and install relevant ImageJ plugins
- TrackMate

The code is divided into Macros (ImageJ macros) and Notebooks (Jupyter notebooks). 
Part of the analysis pipeline requires (semi-)manual user input via ImageJ/Fiji, the other part integrates all user-generated outputs, saves meta-statistics and finalises data visualisation.

1. Starting point are TrackMate result tables (generated either by manual or automated tracking of cells across generations)
2. These will be analysed via the jupyter notebook '01_Parse_Trackmate_Lineages.ipynb' to generate per tracked video a new '_lineages' dataframe as well as a global summary dataframe
3. Next, using the semi-automatic ImageJ macro '01_Annotate_Mitotic_Onset.ijm', the user annotates the mitotic onset (i.e. nuclear envelope breakdown) for each splitting event (anaphase).
4. Again in ImageJ ('02_Annotate_MitoticErrors.ijm'), the user can annotate mitotic defects and segregation errors, and annotate deaths or loss of daughters ('03_Annotate_Endpoints.ijm"). 
5. Next, via the Notebook '02_Integrate_Onsets_Defects_Endpoints.ipynb', lineage information will be merged with mitotic durations and mitotic error events.
6. Finally, via the Notebook '03_Visualisation_Statistics.ipynb', the data can be filtered in various ways (such as selecting mother cell cohorts, or excluding division with errors) and visualised using the python library altair.

Please note that this repository is mainly published for documentation within the context of a series of custom experiments, and was not optimised for user-friendliness! Please feel encouraged to ask for help if needed. 
