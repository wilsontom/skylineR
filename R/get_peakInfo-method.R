#' get_peakInfo
#' @rdname get_peakInfo
#'
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod("get_peakInfo", signature = "skyline",
          function(object) {
            objectName <- as.list(match.call())$object

            write.csv(
              object@transitions,
              file = paste0(object@path, "/", "transitions_temp.csv"),
              row.names = FALSE
            )

            options(SkylineObject = object)

            purrr::map(as.list(object@filepaths), skyline_runner)

            file.remove(paste0(object@path, "/transitions_temp.csv"))


            result_reports <-
              list.files(object@path, pattern = ".csv", full = TRUE)

            results_raw <- map(as.list(result_reports), read.csv)

            PeakArea <- map(results_raw, ~ {
              as_tibble(.) %>%
                mutate_all(., as.character) %>%
                select(TransitionName = ProteinName,
                       SampleName = ReplicateName,
                       Area = Area) %>%
                tidyr::spread(., TransitionName, Area)
            }) %>%
              bind_rows()

            PeakNoise <- map(results_raw, ~ {
              as_tibble(.) %>%
                mutate_all(., as.character) %>%
                select(TransitionName = ProteinName,
                       SampleName = ReplicateName,
                       Noise = Background) %>%
                tidyr::spread(., TransitionName, Noise)
            }) %>%
              bind_rows()

            RetTime <- map(results_raw, ~ {
              as_tibble(.) %>%
                mutate_all(., as.character) %>%
                select(
                  TransitionName = ProteinName,
                  SampleName = ReplicateName,
                  RetentionTime = RetentionTime
                ) %>%
                tidyr::spread(., TransitionName, RetentionTime)
            }) %>%
              bind_rows()

            object@peakInfo <-
              list(PeakArea = PeakArea,
                   PeakNoise = PeakNoise,
                   RetentionTime = RetTime)

            assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)
          })
