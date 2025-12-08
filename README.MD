# C++ GSL Research Computing Project Setup

## Description
This project provides a complete C++ setup for running parallel simulations using the GNU Scientific Library (GSL) on the UTEP Punakha HPC system. 

**Key Components:**
- **Makefile**: Pre-configured to link GSL libraries via module loads
- **folder_create.sh**: Generates multiple simulation directories from a base template, allowing you to run parameter sweeps or variations
- **job_sims.sbatch**: SLURM job array script that distributes simulations across multiple cores and nodes, with automatic module verification and per-simulation logging

This workflow enables efficient execution of embarrassingly parallel simulations where each run is independent and can execute concurrently on HPC infrastructure. 

## Prerequisites
- C++ compiler (g++ or clang)
- GNU Scientific Library (GSL)
- make
- cmake
- SLURM (for HPC job submission)
- FileZilla (for file transfer to HPC)

## Setup Instructions

### 1. Navigate to your work directory on HPC
```bash
cd ~/work/username/
```

### 2. Create a folder for your project (e.g. cplus)
```bash
mkdir cplus
cd cplus
```

### 3. Create the base folder and upload source files
```bash
mkdir base
```
Use **FileZilla** to upload your `Makefile` and `main.cpp` to the `base/` folder

### 4. Upload the folder creation script
Use **FileZilla** to upload `folder_create.sh` to the `cplus/` root directory

### 5. Make the script executable
```bash
chmod +x folder_create.sh
```

### 6. On the login node run the script to generate simulation folders. In this example it will create sim1..sim10
```bash
./folder_create.sh 1 10
# This will create sim1, sim2, sim3, ... sim10 directories with copies of base files
```

## Running Simulations on HPC

### Submit SLURM job array
```bash
sbatch --array=1-10 scripts/job_sims.sbatch
# This runs 10 simulations in parallel, each using 1 CPU core
```

### Monitor job status
```bash
squeue -u username
# Check job progress and status
```

### Change array range
```bash
sbatch --array=1-50 scripts/job_sims.sbatch
# Run simulations 1 through 50
```

## File Structure
```
cplus/
├── base/                    # Template folder with Makefile and main.cpp
├── sim1/                    # Generated simulation folders
│   ├── Makefile
│   ├── main.cpp
│   ├── a.out               # Compiled executable
│   ├── output.log          # Simulation output
│   └── error.log           # Error messages (if any)
├── sim2/
├── ...
├── folder_create.sh         # Script to generate simulation directories
├── scripts/
│   └── job_sims.sbatch     # SLURM batch script for HPC job submission
└── README.MD                # This file
```

## Key Features

### SLURM Configuration
- **Partition**: dgx (GPU node)
- **CPUs per task**: 1 core per simulation
- **Memory**: 1GB per task
- **Time limit**: 30 minutes
- **GPU**: 1 GPU available

### Output Management
- Each simulation writes its own `output.log` and `error.log` in its folder
- Easy to track results per simulation
- No cluttered root directory

## Module Loading
The script automatically loads required modules:
- `cmake` - Build system
- `gnu12` - GCC compiler
- `gsl` - GNU Scientific Library

## Tips
- Adjust `--array=1-10` to match your number of simulations
- Check `sim1/output.log` to verify the setup is working
- Use `cat sim1/error.log` to debug compilation or execution issues
- Increase `--time=00:30:00` if simulations take longer than 30 minutes
- Each simulation runs independently and in parallel

## Troubleshooting

### Line ending errors
If you get: `sbatch: error: Batch script contains DOS line breaks`
- Click on `CRLF` at the bottom right of VS Code
- Change to `LF` for Unix line endings

### Folder creation fails
```bash
# Make sure folder_create.sh has execute permissions
chmod +x folder_create.sh

# Check that base/ folder exists with files
ls -la base/
```

### Job submission fails
```bash
# Check SLURM syntax
sbatch --help

# Verify script has proper permissions
ls -l scripts/job_sims.sbatch
```

