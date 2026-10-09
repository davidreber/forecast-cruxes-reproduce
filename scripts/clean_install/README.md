# Clean-install verification on a Slurm cluster

Three jobs, chained with `--dependency=afterok`, that produced `VERIFICATION.md`:

1. `01_install.slurm` (CPU, internet): fresh venv, `forecast-cruxes` from its
   GitHub tag, this repository and the data release cloned from GitHub, both
   test suites, the manifest check, the prepared inputs, the dry-run plan, and
   the reranker downloaded into a fresh Hugging Face cache (about 16 GB).
2. `02_gpu.slurm` (array of ten GPU tasks): `cruxes-score` for the six runs
   at 25 cruxes a side and the run at 50 a side in four slices.
3. `03_cpu.slurm` (CPU): reports, comparison with the recorded scores, the
   verdict and the figures.

Edit the `#SBATCH` partition, constraint and log paths for your site, set
`BASE` to a scratch directory with about 60 GB free, then:

    j1=$(sbatch --parsable 01_install.slurm)
    j2=$(sbatch --parsable --dependency=afterok:$j1 02_gpu.slurm)
    sbatch --dependency=afterok:$j2 03_cpu.slurm

The run recorded in `VERIFICATION.md` cloned the data release from its own
repository. The data now ships in this repository under `data/`: point
`--artifact` at `data` and drop the separate clone in `01_install.slurm`.
