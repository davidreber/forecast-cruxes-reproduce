#!/usr/bin/bash
#SBATCH --partition=general,veitch
#SBATCH --job-name=clean_verify_install
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32GB
#SBATCH --time=06:00:00
#SBATCH --kill-on-invalid-dep=yes
#SBATCH --output=logs/clean_verify_install_%j.out
#SBATCH --error=logs/clean_verify_install_%j.err
#
# Clean-install verification of the PUBLIC repositories, stage 1 (CPU, needs
# internet): a fresh venv with nothing of the authors' in it, the package from
# its GitHub tag, the verifier and its data release cloned from GitHub as one repository, both
# test suites, the manifest check, the prepared inputs, the dry-run plan, and
# the pinned reranker revision downloaded into a fresh Hugging Face cache.
#
#   GH=file:///path/to/release_2026-10-08 sbatch 01_install.slurm   # local repos instead of GitHub
set -eo pipefail
BASE=${BASE:-/scratch/clean_verify}
GH=${GH:-https://github.com/davidreber}
PKG_REF=${PKG_REF:-v0.4.0}
REP_REF=${REP_REF:-v0.1.0}
BASE_PYTHON=${BASE_PYTHON:-python3}
export HF_HOME="$BASE/hf_cache" PYTHONDONTWRITEBYTECODE=1 PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
echo "host: $(hostname)  date: $(date)  base python: $($BASE_PYTHON --version)  source: $GH"
rm -rf "$BASE"; mkdir -p "$BASE/src"; cd "$BASE"

"$BASE_PYTHON" -m venv venv
venv/bin/pip install --upgrade pip
venv/bin/pip install "forecast-cruxes[gpu,test] @ git+$GH/forecast-cruxes@$PKG_REF"
git clone --quiet --branch "$PKG_REF" --depth 1 "$GH/forecast-cruxes" src/forecast-cruxes
git clone --quiet --branch "$REP_REF" --depth 1 "$GH/forecast-cruxes-reproduce" src/forecast-cruxes-reproduce
venv/bin/pip install -e "src/forecast-cruxes-reproduce[test,figures]"
ln -s "$BASE/src/forecast-cruxes-reproduce/data" RELEASE
venv/bin/pip freeze > freeze.txt
echo "commits: package $(git -C src/forecast-cruxes rev-parse --short HEAD), reproduce $(git -C src/forecast-cruxes-reproduce rev-parse --short HEAD)"
venv/bin/python -c "import cruxes, cruxes_verify, sys; print('installed', cruxes.__version__, cruxes.__file__); print('verify', cruxes_verify.__version__); assert 'torch' not in sys.modules"
venv/bin/python -c "import torch, transformers; print('torch', torch.__version__, 'transformers', transformers.__version__)"

echo "== package tests"; (cd src/forecast-cruxes && ../../venv/bin/python -m pytest tests -q -p no:cacheprovider)
echo "== verifier tests"; (cd src/forecast-cruxes-reproduce && ../../venv/bin/python -m pytest tests -q -p no:cacheprovider)
echo "== manifest, prepare, plan"
venv/bin/cruxes-verify check --artifact RELEASE
venv/bin/cruxes-verify prepare --artifact RELEASE --work-dir work
venv/bin/cruxes-verify score --artifact RELEASE --work-dir work --dry-run
echo "== model download (pinned revision) into $HF_HOME"
venv/bin/python -c "from huggingface_hub import snapshot_download; p = snapshot_download('Qwen/Qwen3-Reranker-8B', revision='5fa94080caafeaa45a15d11f969d7978e087a3db'); print('model at', p)"
du -sh "$HF_HOME"
echo "stage 1 done $(date)"
