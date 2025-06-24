# Free energy calculations for HER2 V597M mutation with Trastuzumab

This repository contains the environment configuration, code, and instructions to reproduce the alchemical free energy calculations used to predict the relative binding free energy change of the HER2 V597M mutation to Trastuzumab. 

## Getting Started 

To reproduce this analysis

0. **Pre-requisites**
To run this analysis an OpenEye software license must be attained and added to your PATH. Please follow instructions here https://docs.eyesopen.com/applications/common/license.html

1. **Clone this repository**

```bash
git clone https://github.com/joshualausj/HER2_V597M/
cd HER2_V597M
```

2. **Create conda environment**
```bash
conda env create -f environment.yml
conda activate perses
```
3. **Generate HybridTopologyFactory (HTF) objects**
```bash
cd fec
bsub -J "htfs[1]" < submit_htfs_HER2ecIV.sh
```
Our system uses LSF. Please reconfigure this and subsequent scripts / commands to your own HPC scheduler. 

This should create a directory ```htfs``` which includes the solvated apo and complexed, mutant and wildtype pdb structures, using the input .pdb structures.
Please note that V597 is indexed as V65 as we use a .pdb file containing only extracellular domain IV of HER2. 

4. **neq calculations**

This step runs non-equilibrium cycling simulations with 100 replicates, outputting into a folder ```neqs``` 


```bash
./submit_all_neqs_round2.sh
```
5. **final analysis**

This step plots and outputs the work distributions, trajectories, and relative free energy into a directory ```analysis```. the analysis output for the results described in the manuscript are included as a reference in ```fec/analysis_reference```

```bash
bsub -J "analysis[1]" < submit-analysis-neq.sh
```


