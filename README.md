
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Wearable-R!

<!-- badges: start -->

<!-- badges: end -->

Wearable-R is a short course on accelerometry and wearable-data
analysis. It follows the path from raw device files to reproducible
participant-level and profile-based analyses, using R and the
`activerse` ecosystem.

## What the course covers

The nine modules cover:

1.  **Devices and signals** — what accelerometers measure, how common
    devices differ, and how data are collected in large studies.
2.  **Import and structure** — reading raw files and placing timestamps
    and three-axis acceleration in a common representation.
3.  **Calibration** — assessing and documenting the decisions needed to
    make raw acceleration usable and comparable.
4.  **Signal metrics** — deriving and comparing ENMO, MAD, MIMS, and
    activity counts from standardized raw data.
5.  **Wear and visualization** — inferring wear time and visualizing a
    participant’s complete seven-day record.
6.  **Valid days** — defining eligible participant-days and reporting
    data attrition.
7.  **Daily and participant summaries** — aggregating minute-level data
    into daily measures and one value per participant.
8.  **Downstream and functional analysis** — modeling participant
    summaries and 24-hour activity profiles.
9.  **Reproducibility, quality control, and other methods** — building
    an auditable pipeline and incorporating specialized methods,
    including Python tools through `reticulate`.

Each module pairs a focused question with an example dataset, moving
from a short raw segment to a full example project.
