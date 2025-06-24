#!/bin/bash

MUTATIONS=('VAL65MET')
PHASES=('apo' 'complex')
LIGANDS=('Fv')

for mutation in "${MUTATIONS[@]}"; do
  for phase in "${PHASES[@]}"; do
    for ligand in "${LIGANDS[@]}"; do
      sed -i "24s/.*/LIGAND=${ligand}/" submit_neq_round2.sh
      sed -i "25s/.*/PHASE=${phase}/" submit_neq_round2.sh
      sed -i "26s/.*/MUTATION=${mutation}/" submit_neq_round2.sh
      bsub -sp 20 -m "lc-gpu lx-gpu ly-gpu lj-gpu ll-gpu ln-gpu lz-gpu lf-gpu ld-gpu lk-gpu" -J "${ligand}_${phase}_${mutation}[1-100]" < submit_neq_round2.sh
    done
  done
done


