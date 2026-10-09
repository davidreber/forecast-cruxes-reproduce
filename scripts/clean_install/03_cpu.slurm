#!/usr/bin/bash
#SBATCH --partition=general,veitch
#SBATCH --job-name=clean_verify_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32GB
#SBATCH --time=06:00:00
#SBATCH --kill-on-invalid-dep=yes
#SBATCH --output=logs/clean_verify_cpu_%j.out
#SBATCH --error=logs/clean_verify_cpu_%j.err
#
# Clean-install verification, stage 3 (CPU): reports, the comparison with the
# paper's numbers (with the recorded scores shipped in the data release, so all
# 109 checks run), the verdict and the figures. Submit with
# --dependency=afterok:<stage 2 array job id>.
set -uo pipefail
BASE=${BASE:-/scratch/clean_verify}
export PYTHONDONTWRITEBYTECODE=1
echo "host: $(hostname)  date: $(date)"
cd "$BASE"
venv/bin/cruxes-verify report --artifact RELEASE --work-dir work || exit 1
venv/bin/cruxes-verify compare --artifact RELEASE --work-dir work --recorded-scores RELEASE/provenance/scores
status=$?
venv/bin/python -m cruxes_verify.figures.render --work-dir work || echo "figures failed"
ls -la work/verification/
echo "verify exit status ${status}  $(date)"
exit ${status}
