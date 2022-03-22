

skyline_docker_runner <- function(object, x)
{

  filepath <- normalizePath(stringr::str_remove_all(x, basename(x)))

  docker_cmd <- glue::glue(
    'docker run --rm -e WINDEDEBUG=-all -v ',
    {
      normalizePath(object@path)
    },
    ':/data -v ',
    {
      filepath
    },
    ':/files chambm/pwiz-skyline-i-agree-to-the-vendor-licenses wine SkylineCmd'
  )

  renametmp <-
    stringr::str_replace(basename(x), '.mzML', '.csv')


  xfile <- glue::glue('/files/', {
    basename(x)
  })

  skyline_cmd <-
    glue::glue(
      '--in=',
      'skyline.sky --import-transition-list=',
      'transitions_temp.csv --import-file=',
      {
        xfile
      },
      ' --report-name=\"Transition Results\" --report-file=',
      {
        renametmp
      },
      ' --report-invariant'
    )


  full_cmd <- glue::glue({
    docker_cmd
  }, ' ', {
    skyline_cmd
  })

  system(full_cmd, intern = TRUE)


  return(invisible(NULL))


}
