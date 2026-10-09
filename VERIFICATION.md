<!-- Header added by the authors; the verdict below is the verifier's output, verbatim. -->

**About this run.** A clean-install run of the public repositories, on the
authors' Slurm cluster, 2026-10-08 to 09: a fresh Python 3.10 venv with
nothing of the authors' in it; `forecast-cruxes` 0.4.0 installed from its
GitHub tag (`be27156`); this repository (`273f205`) and the data release
(`740edc8`, tag v1.0.0) cloned from GitHub; torch 2.14.1+cu130 and
transformers 5.19.0 from PyPI; the reranker downloaded from the Hugging Face
Hub at the pinned revision into a fresh cache; both test suites passed (190
and 87); scoring on ten GPU jobs (four A100 80GB, three H100 NVL, three H200
NVL; 33 minutes to 2 hours 40 minutes each); reports, comparison and verdict
on a CPU job (12 minutes). The scripts are `scripts/clean_install/`. The data release used here
now ships in this repository under `data/`, where two documentation strings have since been
corrected to name the March Madness extractor gpt-5.4-nano, as the run log and the paper
record. No dataset file and no recorded score changed, and the manifest was resealed.

**The gate.** The paper's test is gated at p < 0.01. On the authors' recorded
scores (shipped as `data/provenance/scores/`, the numbers the paper prints) every one of the twelve cells gives p < 1e-4. On this rerun
eleven cells give p < 1e-4 and Metaculus at the broad level
(`metaculus/debate`) with 5 cruxes a side gives p = 0.0019 (observed 0.4156
below the null 0.5353, 18 of 10,000 draws at or below), the same values the
earlier run from the authors' 2026-09-24 score caches gave
(`verification_history/`), so fresh scoring reproduced that run.

# Verification of the paper from the data release

Generated 2026-10-09T00:11:08+00:00.

- release: `/net/spaces/scratch/reber-scratch2/clean_verify_2026-10-08/RELEASE` (release)
- expected numbers: `/net/spaces/scratch/reber-scratch2/clean_verify_2026-10-08/src/forecast-cruxes-verify/src/cruxes_verify/expected`
- recorded scores: `RELEASE/provenance/scores`

**Overall: PASSED** (109 of 109 gated checks passed).

## Tolerances

| check | dataset | tolerance | derivation |
|---|---|---|---|
| headline numbers | march_madness | 0.0355 | 1.5 x 0.0237, the largest |sample 1 - sample 2| between two introspection samples over 18 compared headline numbers (null at 5 a side, debate criterion) |
| headline numbers | metaculus | 0.1588 | 1.5 x 0.1059, the largest |sample 1 - sample 2| between two introspection samples over 18 compared headline numbers (gap at 25 a side, resolution criterion) |
| granularity sweep | march_madness | 0.0495 | 1.5 x 0.0330, the largest |sample 1 - sample 2| between two introspection samples over 20 compared granularity sweep numbers (permutation_shared_mean at resolution 0.1, resolution criterion) |
| within pool split | march_madness | 0.0978 | 1.5 x 0.0652, the largest |sample 1 - sample 2| between two introspection samples over 4 compared within pool numbers (within_introspected_mean at 5 a side, resolution criterion); measured at [5, 12] a side, the checked counts both samples report, and applied also at [25], which the samples (run at 25 a side) do not reach and only the deduplicated run at 50 a side reports |
| removed repeats | every dataset | exact | removing repeated texts is deterministic |
| the paper's test | every dataset | none | observed below the null and p < 0.01 must hold (10,000 permutation draws of the mean, p = (b + 1) / (n + 1)) |
| raw scores | every dataset | 0.05 | 3 x the measured drift between two runs of the same pairs (0.01611); only with recorded scores |

## march_madness/resolution

Rerun report `work/reports/march_madness/resolution/set_inclusion_2026-10-09T00-06-58Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 88 | 88 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 36 | 36 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.0625 | 0.0465 | -0.0160 | 0.0355 | pass |
| headline numbers | null at 5 | 0.1354 | 0.1135 | -0.0218 | 0.0355 | pass |
| headline numbers | gap at 5 | 0.0728 | 0.0670 | -0.0058 | 0.0355 | pass |
| headline numbers | shared at 25 | 0.1336 | 0.1506 | +0.0170 | 0.0355 | pass |
| headline numbers | null at 25 | 0.3921 | 0.4141 | +0.0219 | 0.0355 | pass |
| headline numbers | gap at 25 | 0.2585 | 0.2635 | +0.0050 | 0.0355 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.0473 (472 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.0465, null 0.1140 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.1506, null 0.4138 | | none | pass |
| granularity sweep | shared_frac_mean at resolution 0.1 | 0.2644 | 0.3085 | +0.0441 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.1 | 0.5657 | 0.5787 | +0.0129 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.2 | 0.2458 | 0.2695 | +0.0237 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.2 | 0.5225 | 0.5403 | +0.0178 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.3 | 0.1944 | 0.2124 | +0.0181 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.3 | 0.4835 | 0.4950 | +0.0114 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.4 | 0.1229 | 0.1356 | +0.0127 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.4 | 0.4233 | 0.4332 | +0.0099 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.5 | 0.0644 | 0.0732 | +0.0088 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.5 | 0.3497 | 0.3488 | -0.0010 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.6 | 0.0299 | 0.0345 | +0.0045 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.6 | 0.2621 | 0.2624 | +0.0003 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.7 | 0.0140 | 0.0131 | -0.0010 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.7 | 0.1852 | 0.1823 | -0.0029 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.8 | 0.0051 | 0.0064 | +0.0013 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.8 | 0.1136 | 0.1142 | +0.0006 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 0.9 | 0.0015 | 0.0015 | +0.0000 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 0.9 | 0.0546 | 0.0545 | -0.0001 | 0.0495 | pass |
| granularity sweep | shared_frac_mean at resolution 1.0 | 0.0000 | 0.0000 | +0.0000 | 0.0495 | pass |
| granularity sweep | permutation_shared_mean at resolution 1.0 | 0.0000 | 0.0000 | +0.0000 | 0.0495 | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.01270, median 0.00146, p99 0.00732 over 19364 scores, 59 questions | | 0.05 | pass |

## march_madness/resolution@50

Rerun report `work/reports/march_madness/resolution@50/set_inclusion_2026-10-09T00-08-18Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 88 | 88 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 36 | 36 | +0 | exact | pass |
| within pool split | within_introspected_mean at 5 | 0.2417 | 0.2526 | +0.0109 | 0.0978 | pass |
| within pool split | within_extracted_mean at 5 | 0.1935 | 0.1695 | -0.0241 | 0.0978 | pass |
| within pool split | within_introspected_mean at 12 | 0.4054 | 0.4292 | +0.0237 | 0.0978 | pass |
| within pool split | within_extracted_mean at 12 | 0.3108 | 0.3050 | -0.0058 | 0.0978 | pass |
| within pool split | within_introspected_mean at 25 | 0.5929 | 0.5690 | -0.0239 | 0.0978 | pass |
| within pool split | within_extracted_mean at 25 | 0.4504 | 0.4415 | -0.0089 | 0.0978 | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.01270, median 0.00146, p99 0.00708 over 73504 scores, 59 questions | | 0.05 | pass |

Set inclusion of this run, reported without a verdict (the paper prints it only through the analyses above):

| number | paper | rerun | difference |
|---|---|---|---|
| shared at 5 | 0.0607 | 0.0465 | -0.0142 |
| null at 5 | 0.1358 | 0.1135 | -0.0223 |
| gap at 5 | 0.0751 | 0.0670 | -0.0081 |
| shared at 25 | 0.1335 | 0.1452 | +0.0116 |
| null at 25 | 0.3907 | 0.4055 | +0.0148 |
| gap at 25 | 0.2572 | 0.2603 | +0.0031 |
| shared at 50 | 0.2073 | 0.1860 | -0.0213 |
| null at 50 | 0.5620 | 0.5467 | -0.0154 |
| gap at 50 | 0.3547 | 0.3607 | +0.0059 |

## march_madness/equivalence

Rerun report `work/reports/march_madness/equivalence/set_inclusion_2026-10-09T00-09-20Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 88 | 88 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 36 | 36 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.0264 | 0.0329 | +0.0065 | 0.0355 | pass |
| headline numbers | null at 5 | 0.1061 | 0.1086 | +0.0026 | 0.0355 | pass |
| headline numbers | gap at 5 | 0.0797 | 0.0757 | -0.0039 | 0.0355 | pass |
| headline numbers | shared at 25 | 0.0558 | 0.0600 | +0.0042 | 0.0355 | pass |
| headline numbers | null at 25 | 0.3338 | 0.3281 | -0.0057 | 0.0355 | pass |
| headline numbers | gap at 25 | 0.2780 | 0.2681 | -0.0099 | 0.0355 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.032 (319 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.0329, null 0.1088 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.0600, null 0.3275 | | none | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.00928, median 0.00049, p99 0.00439 over 19364 scores, 59 questions | | 0.05 | pass |

## march_madness/debate

Rerun report `work/reports/march_madness/debate/set_inclusion_2026-10-09T00-09-46Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 88 | 88 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 36 | 36 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.0458 | 0.0514 | +0.0056 | 0.0355 | pass |
| headline numbers | null at 5 | 0.1620 | 0.1350 | -0.0270 | 0.0355 | pass |
| headline numbers | gap at 5 | 0.1162 | 0.0836 | -0.0326 | 0.0355 | pass |
| headline numbers | shared at 25 | 0.1284 | 0.1218 | -0.0066 | 0.0355 | pass |
| headline numbers | null at 25 | 0.4120 | 0.3960 | -0.0160 | 0.0355 | pass |
| headline numbers | gap at 25 | 0.2836 | 0.2742 | -0.0094 | 0.0355 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.0232 (231 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.0514, null 0.1350 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.1218, null 0.3956 | | none | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.01514, median 0.00122, p99 0.00635 over 19364 scores, 59 questions | | 0.05 | pass |

## metaculus/resolution

Rerun report `work/reports/metaculus/resolution/set_inclusion_2026-10-09T00-09-51Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 321 | 321 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 8 | 8 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.2901 | 0.2756 | -0.0145 | 0.1588 | pass |
| headline numbers | null at 5 | 0.4948 | 0.4433 | -0.0516 | 0.1588 | pass |
| headline numbers | gap at 5 | 0.2048 | 0.1677 | -0.0370 | 0.1588 | pass |
| headline numbers | shared at 25 | 0.3989 | 0.3915 | -0.0074 | 0.1588 | pass |
| headline numbers | null at 25 | 0.7094 | 0.6148 | -0.0946 | 0.1588 | pass |
| headline numbers | gap at 25 | 0.3105 | 0.2233 | -0.0872 | 0.1588 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.0162 (161 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.2756, null 0.4436 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.3915, null 0.6142 | | none | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.00830, median 0.00098, p99 0.00715 over 272 scores, 15 questions | | 0.05 | pass |

## metaculus/equivalence

Rerun report `work/reports/metaculus/equivalence/set_inclusion_2026-10-09T00-09-56Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 321 | 321 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 8 | 8 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.2711 | 0.2144 | -0.0567 | 0.1588 | pass |
| headline numbers | null at 5 | 0.4586 | 0.3870 | -0.0715 | 0.1588 | pass |
| headline numbers | gap at 5 | 0.1875 | 0.1726 | -0.0149 | 0.1588 | pass |
| headline numbers | shared at 25 | 0.2193 | 0.2810 | +0.0617 | 0.1588 | pass |
| headline numbers | null at 25 | 0.5803 | 0.5876 | +0.0073 | 0.1588 | pass |
| headline numbers | gap at 25 | 0.3610 | 0.3066 | -0.0544 | 0.1588 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.0232 (231 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.2144, null 0.3855 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.2810, null 0.5873 | | none | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.00610, median 0.00067, p99 0.00495 over 272 scores, 15 questions | | 0.05 | pass |

## metaculus/debate

Rerun report `work/reports/metaculus/debate/set_inclusion_2026-10-09T00-10-01Z.json`.

| check | number | paper | rerun | difference | tolerance | |
|---|---|---|---|---|---|---|
| removed repeats | removed introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | removed extracted | 321 | 321 | +0 | exact | pass |
| removed repeats | questions_with_repeats introspected | 0 | 0 | +0 | exact | pass |
| removed repeats | questions_with_repeats extracted | 8 | 8 | +0 | exact | pass |
| headline numbers | shared at 5 | 0.3389 | 0.4156 | +0.0767 | 0.1588 | pass |
| headline numbers | null at 5 | 0.5429 | 0.5365 | -0.0064 | 0.1588 | pass |
| headline numbers | gap at 5 | 0.2040 | 0.1209 | -0.0831 | 0.1588 | pass |
| headline numbers | shared at 25 | 0.3967 | 0.4598 | +0.0631 | 0.1588 | pass |
| headline numbers | null at 25 | 0.6895 | 0.6958 | +0.0064 | 0.1588 | pass |
| headline numbers | gap at 25 | 0.2927 | 0.2360 | -0.0567 | 0.1588 | pass |
| the paper's test | paper's test at 5 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 0.0157 (156 of 10000 draws at or below)) | p 0.0019 (18 of 10000 draws at or below), observed 0.4156, null 0.5353 | | none | pass |
| the paper's test | paper's test at 25 | p < 0.01, observed below the null (recorded scores, per question seeds: p 9.999e-05 (0 of 10000 draws at or below); earlier calibration with constant seed 42: p 9.999e-05 (0 of 10000 draws at or below)) | p 9.999e-05 (0 of 10000 draws at or below), observed 0.4598, null 0.6950 | | none | pass |
| raw scores | max over shared premise pairs | recorded scores | max 0.00684, median 0.00098, p99 0.00569 over 272 scores, 15 questions | | 0.05 | pass |

