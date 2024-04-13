#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --time=3-00:00:00
#SBATCH --mem=1000gb
#SBATCH -o MTXEN.out
#SBATCH -p hsph

module load python
module load trimmomatic
 
# Get the folder name from input
folder_name=$1
echo "$folder_name"
 
# Get the current path of the folder where the bash file is being stored
current_path=$(pwd)
echo "$current_path"
 
# Construct the CATDIR and OUTDIR variables using the current path and folder name
CATDIR="${current_path}/${folder_name}"
echo "$CATDIR"
OUTDIR="${current_path}/${folder_name}_output"
echo "$OUTDIR"

# Create the CATDIR and OUTDIR directories if they don't exist
mkdir -p $OUTDIR

biobakery_workflows wmgx --input ${CATDIR} -o ${OUTDIR} --pair-identifier _R1 --input-extension fastq --remove-intermediate-output --bypass-strain-profiling --qc-options="--bypass-trf" --threads 14 --local-jobs 8
