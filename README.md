
<!-- README.md is generated from README.Rmd. Please edit that file -->

<div style="font-size: 30px;">

[Rendered Page at
https://jhuwit.github.io/wearabler/](https://jhuwit.github.io/wearabler/)

</div>

# Wearable-R!

<div style="text-align: center;">

<img src="assets/wearabler_qrcode.png" width="200" />

</div>

<!-- badges: start -->

<!-- badges: end -->

Wearable-R is a short course on accelerometry and wearable-data
analysis. It follows the path from raw device files to reproducible
participant-level and profile-based analyses, using R and the
`activerse` ecosystem.

## What the course covers

The current modules cover:

1.  **Module 1: Accelerometer Devices and Studies** — what
    accelerometers measure, how common devices differ, and how data are
    collected in large studies.
2.  **Module 2: Reading and Processing Data** — reading raw files,
    inspecting signal quality, gravity calibration, activity counts, and
    non-wear processing.
3.  **Module 3: Activity Metrics** — deriving and comparing ENMO, MAD,
    MIMS, activity counts, steps, and other minute-level movement
    measures.
4.  **Module 4: Analysis and Summaries** — visualizing population
    activity profiles, creating summaries, and modeling functional
    activity data.
5.  **Module 99: Reproducibility, QC, and Other Methods** — building an
    auditable pipeline and incorporating specialized methods, including
    Python tools through `reticulate`.

Each module pairs a focused question with an example dataset, moving
from a short raw segment to a full example project.

# Materials

Materials are at: <https://github.com/jhuwit/wearabler>

Can use `git clone` or download via:
<https://github.com/jhuwit/wearabler/archive/refs/heads/main.zip>

# Loading `targets` and environment

Using [`renv`](https://rstudio.github.io/renv/articles/renv.html) allows
us to specify the packages used to build this pipeline:

``` r
renv::restore()
```

The [`targets`](https://books.ropensci.org/targets/) pipeline located
[in the GitHub
repo](https://github.com/jhuwit/wearabler/blob/main/_targets.R) will do
the processing (and allows us to cache the pipeline).

``` r
targets::tar_make()
```
