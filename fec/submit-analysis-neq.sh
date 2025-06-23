#!/bin/bash

# run for 30 min
#BSUB -W 00:30

# use no more than 8GB/thread-slot
#BSUB -R "rusage[mem=8]"

# use 1 thread-slots
#BSUB -n 1

# use the CPU queue
#BSUB -q cpuqueue

# write stdout to this file
#BSUB -o %J.log

# run with https://github.com/choderalab/perses/commit/c790a780a20367c7415a86d50879e0983456d92b

MUTATIONS=('VAL65MET')
PHASES=('apo' 'complex')
LIGANDS=('Fv')
LIGAND_NAME=Fv

source ~/.bashrc
module load cuda/10.2
conda activate /home/lauj2/miniconda3/envs/perses

i=$(expr $LSB_JOBINDEX - 1)
python scripts/analyze_neq.py -i neqs/${LIGAND_NAME}/${MUTATIONS[i]}/ -d "met ${LIGAND_NAME} ${MUTATIONS[i]}"

