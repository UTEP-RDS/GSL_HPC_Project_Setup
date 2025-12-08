#!/bin/bash
#SBATCH --job-name=cplus
#SBATCH --output=cplus_%j.txt
#SBATCH --error=cplus_%j.err
#SBATCH --partition=dgx
#SBATCH --qos=punakha_dgx_general
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --time=10:00:00

module load cmake
module load gnu12
module load gsl

./a.out