#!/bin/bash

# run for 4 hours
#BSUB -W 4:00

# use no more than 8GB/thread-slot
#BSUB -R "rusage[mem=2]"

# use 1 thread-slots
#BSUB -n 8

# use the CPU queue
#BSUB -q cpuqueue

# write stdout to this file
#BSUB -o %J.htf.log

# run with https://github.com/choderalab/perses/commit/c790a780a20367c7415a86d50879e0983456d92b

MUTATIONS=('VAL65MET')
LIGAND_NAME=Fv
PROTEIN_FILE='../18NZ_EC_IV_colabfold_fixed_cap.pdb'
LIGAND_FILE='../1N8Z_AB_scFv_capped.pdb'

i=$(expr $LSB_JOBINDEX-1)

source ~/.bashrc
module load cuda/10.2
conda activate perses

echo "Processing index $LSB_JOBINDEX"
# echo "Processing i index $LSB_JOBINDEX-1"
# echo "Processing i index $i"
echo "Processing mutation ${MUTATIONS[$LSB_JOBINDEX-1]}"
# python scripts/setup_mutation_htf.py -o htfs-cpu-try2/${LIGAND_NAME}/${MUTATIONS[i]} -p ${PROTEIN_FILE} -l ${LIGAND_FILE} -m ${MUTATIONS[i]}
python scripts/setup_mutation_htf.py -o htfs/${LIGAND_NAME}/${MUTATIONS[$LSB_JOBINDEX-1]} -p ${PROTEIN_FILE} -l ${LIGAND_FILE} -m ${MUTATIONS[$LSB_JOBINDEX-1]}
