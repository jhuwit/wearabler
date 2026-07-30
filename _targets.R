# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(activerse)
options(digits.secs = 3)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("tidyverse", "activerse") # Packages that your targets need for their tasks.
  # format = "qs", # Optionally set the default storage format. qs is fast.
  #
  # Pipelines that take a long time to run may benefit from
  # optional distributed computing. To use this capability
  # in tar_make(), supply a {crew} controller
  # as discussed at https://books.ropensci.org/targets/crew.html.
  # Choose a controller that suits your needs. For example, the following
  # sets a controller that scales up to a maximum of two workers
  # which run as local R processes. Each worker launches when there is work
  # to do and exits if 60 seconds pass with no tasks to run.
  #
  #   controller = crew::crew_controller_local(workers = 2, seconds_idle = 60)
  #
  # Alternatively, if you want workers to run on a high-performance computing
  # cluster, select a controller from the {crew.cluster} package.
  # For the cloud, see plugin packages like {crew.aws.batch}.
  # The following example is a controller for Sun Grid Engine (SGE).
  #
  #   controller = crew.cluster::crew_controller_sge(
  #     # Number of workers that the pipeline can scale up to:
  #     workers = 10,
  #     # It is recommended to set an idle time so workers can shut themselves
  #     # down if they are not running tasks.
  #     seconds_idle = 120,
  #     # Many clusters install R as an environment module, and you can load it
  #     # with the script_lines argument. To select a specific verison of R,
  #     # you may need to include a version string, e.g. "module load R/4.3.2".
  #     # Check with your system administrator if you are unsure.
  #     script_lines = "module load R"
  #   )
  #
  # Set other options as needed.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(

  tar_file(
    file_gt3x_large,
    here::here("data/AI15_MOS2D09170398_2017-10-30.gt3x")
  ),

  tar_target(
    data,
    command = {
      actiread::acti_read_gt3x(file_gt3x_large)
    }
    # format = "qs" # Efficient storage for general data objects.
  ),
  tar_target(min_data,
             {
               actimetrics::acti_process(data)
             }),

  tar_file(
    file_gt3x,
    here::here("data/TAS1H30182791 (2026-04-29).gt3x")
  ),

  tar_file(
    file_cwa,
    here::here("data/114890_0000000000.cwa")
  ),


  tar_target(
    data_gt3x,
    command = {
      actiread::acti_read_gt3x(file_gt3x)
    }
  ),

  tar_target(
    data_cwa,
    command = {
      actiread::acti_read_cwa(file_cwa)
    }
  ),

  tar_target(
    data_cwa_py,
    {
      reticulate::py_require(c("actipy", "pyarrow"))
      actiread::acti_py_read_cwa(file_cwa)
    }
  ),

  tar_target(
    min_gt3x,
    {
      actimetrics::acti_process(data_gt3x)
    }),

  tar_target(
    min_cwa,
    {
      actimetrics::acti_process(data_cwa)
    }),

  tar_target(
    min_cwa_py,
    {
      actimetrics::acti_process(data_cwa_py)
    }),


  # Calibrate
  tar_target(data_cal,
             {
               acti_calibrate(data)
             }),

  tar_target(data_gt3x_cal,
             {
               data_gt3x |>
                 actibase::acti_remove_leading_zeros() |>
                 acti_calibrate()
             }),

  tar_target(data_cwa_cal,
             {
               acti_calibrate(data_cwa)
             }),

  tar_target(data_cwa_py_cal,
             {
               acti_calibrate(data_cwa_py)
             }),

  # Process
  tar_target(data_proc,
             {
               acti_process(data)
             }),

  tar_target(data_gt3x_proc,
             {
               acti_process(data_gt3x)
             }),

  tar_target(data_cwa_proc,
             {
               acti_process(data_cwa)
             }),

  tar_target(data_cwa_py_proc,
             {
               acti_process(data_cwa_py)
             }),

  tar_target(stepcount_pyenv,
             {

               stepcount_pyenv = function() {
                 library(stepcount)
                 reticulate::py_require("stepcount==3.11.0", python_version = "3.10")
                 reticulate::import("stepcount")
               }
             }),

  tar_target(
    steps,
    {
      actimetrics::py_acti_calculate_stepcount(
        data = data,
        sample_rate = get_sample_rate(data),
        model_type = "ssl",
        pyenv_function = stepcount_pyenv,
        show = TRUE
      )
    }
  ),


  tar_target(
    steps_gt3x,
    {
      actimetrics::py_acti_calculate_stepcount(
        data = data_gt3x,
        sample_rate = get_sample_rate(data_gt3x),
        model_type = "ssl",
        pyenv_function = stepcount_pyenv,
        show = TRUE
      )
    }
  ),


  tar_target(
    steps_cwa,
    {
      actimetrics::py_acti_calculate_stepcount(
        data = data_cwa,
        sample_rate = get_sample_rate(data_cwa),
        model_type = "ssl",
        pyenv_function = stepcount_pyenv,
        show = TRUE
      )
    }
  ),

  tar_target(
    steps_cwa_py,
    {
      actimetrics::py_acti_calculate_stepcount(
        data = data_cwa_py,
        sample_rate = get_sample_rate(data_cwa_py),
        model_type = "ssl",
        pyenv_function = stepcount_pyenv,
        show = TRUE
      )
    }
  ),

  tar_target(
    actinet,
    {
      actinet::py_acti_net(
        data,
        sample_rate = get_sample_rate(data)
      )
    }
  ),

  tar_target(
    actinet_gt3x,
    {
      actinet::py_acti_net(
        data_gt3x,
        sample_rate = get_sample_rate(data_gt3x)
      )
    }
  ),

  tar_target(
    actinet_cwa,
    {
      actinet::py_acti_net(
        data_cwa,
        sample_rate = get_sample_rate(data_cwa)
      )
    }
  ),



  tar_target(
    asleep,
    {
      asleep::py_asleep(
        data,
        sample_rate = get_sample_rate(data)
      )
    }
  ),

  tar_target(
    asleep_gt3x,
    {
      asleep::py_asleep(
        data_gt3x,
        sample_rate = get_sample_rate(data_gt3x)
      )
    }
  ),

  tar_target(
    asleep_cwa,
    {
      asleep::py_asleep(
        data_cwa,
        sample_rate = get_sample_rate(data_cwa)
      )
    }
  )

)
