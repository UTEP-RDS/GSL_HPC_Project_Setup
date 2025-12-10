#!/bin/bash
#SBATCH --job-name=parallel-simulations
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null
#SBATCH --partition=dgx          
#SBATCH --qos=punakha_dgx_general
#SBATCH --nodes=1               
#SBATCH --ntasks=10           
#SBATCH --cpus-per-task=1      
#SBATCH --time=02:00:00
#SBATCH --mem=0             
#SBATCH --time=02:00:00
#SBATCH --array=1-10

SIM_NUM=$SLURM_ARRAY_TASK_ID
SIM_DIR="sim${SIM_NUM}"

# Redirect output and error to files in the simulation folder
exec 1>"$SIM_DIR/output.log"
exec 2>"$SIM_DIR/error.log"

echo "Loading modules"

module load cmake
module load gnu12
module load gsl

# Verify modules are loaded
echo "Verifying modules..."
module list

echo "Starting simulation $SIM_NUM in $SIM_DIR"

if [ ! -d "$SIM_DIR" ]; then
    echo "ERROR: Directory $SIM_DIR does not exist"
    exit 1
fi

cd "$SIM_DIR" || exit 1

if ! make; then
    echo "ERROR: Compilation failed for sim$SIM_NUM"
    exit 1
fi

./a.out

echo "Completed simulation $SIM_NUM"

