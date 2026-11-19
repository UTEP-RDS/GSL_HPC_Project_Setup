#!/bin/bash
#SBATCH --job-name=parallel-simulations-omp
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null
#SBATCH --partition=hgx
#SBATCH --qos=punakha_hgx_general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --array=1-10

SIM_NUM=$SLURM_ARRAY_TASK_ID
SIM_DIR="sim${SIM_NUM}"

# Redirect output and error to files in the simulation folder
exec 1>"$SIM_DIR/output.log"
exec 2>"$SIM_DIR/error.log"

# Log start/end times and elapsed seconds on every exit path.
# SIGTERM is converted to a normal exit so the EXIT trap runs when Slurm hits --time.
START_EPOCH=$(date +%s)
trap 'exit 143' TERM
trap 'END_EPOCH=$(date +%s); echo "End time: $(date "+%Y-%m-%d %H:%M:%S %Z") (epoch $END_EPOCH)"; echo "Elapsed seconds: $((END_EPOCH - START_EPOCH))"' EXIT

echo "Job $SLURM_JOB_ID array task $SIM_NUM"
echo "Start time: $(date "+%Y-%m-%d %H:%M:%S %Z") (epoch $START_EPOCH)"

echo "Loading modules"

module load cmake
module load gnu12
module load gsl

# Verify modules are loaded
echo "Verifying modules..."
module list

# One OpenMP thread per core allocated to this array task
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export OMP_PROC_BIND=close
export OMP_PLACES=cores
echo "Node: $(hostname), OMP_NUM_THREADS=$OMP_NUM_THREADS"
echo "CPU affinity: $(taskset -cp $$)"

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
