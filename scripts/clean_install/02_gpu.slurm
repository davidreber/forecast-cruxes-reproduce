#!/usr/bin/bash
#SBATCH --partition=general,veitch
#SBATCH --job-name=clean_verify_gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64GB
#SBATCH --gres=gpu:1
#SBATCH --constraint="a100|h100|h200"
#SBATCH --time=12:00:00
#SBATCH --array=0-9
#SBATCH --kill-on-invalid-dep=yes
#SBATCH --output=logs/clean_verify_gpu_%A_%a.out
#SBATCH --error=logs/clean_verify_gpu_%A_%a.err
#
# Clean-install verification, stage 2 (GPU): cruxes-score for one run per
# array task, from the venv and clones that 01_install.slurm made. Tasks 0 to
# 5 are the six runs at 25 cruxes a side; 6 to 9 split the run at 50 a side.
# Submit with --dependency=afterok:<stage 1 job id>.
set -eo pipefail
BASE=${BASE:-/scratch/clean_verify}
export HF_HOME="$BASE/hf_cache" HF_HUB_OFFLINE=1 PYTHONDONTWRITEBYTECODE=1
RUNS=(
    march_madness/resolution
    march_madness/equivalence
    march_madness/debate
    metaculus/resolution
    metaculus/equivalence
    metaculus/debate
    "march_madness/resolution@50 --array-task-id 0 --num-array-tasks 4"
    "march_madness/resolution@50 --array-task-id 1 --num-array-tasks 4"
    "march_madness/resolution@50 --array-task-id 2 --num-array-tasks 4"
    "march_madness/resolution@50 --array-task-id 3 --num-array-tasks 4"
)
RUN=${RUNS[${SLURM_ARRAY_TASK_ID}]}
echo "host: $(hostname)  date: $(date)  run: ${RUN}"
nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
cd "$BASE"
venv/bin/cruxes-verify score --artifact RELEASE --work-dir work --run ${RUN}
echo "task done $(date)"
