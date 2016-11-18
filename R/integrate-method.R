








setGeneric(name = "analyse",
			def = function(object)
			{standardGeneric("analyse")}
)


setMethod("analyse", signature = "skyline",
			function(object){
			
			objectName <- as.list(match.call())$object

			# add check statement here
			rawfiles <- object@filepaths
			
			# create a temporary Transition.csv file
			
			write.csv(object@transitions, file = paste(object@tempPath, "transitions.csv", sep = "/"), row.names = FALSE)
			
			
			for(i in seq_along(rawfiles)){
				SKYLINE <- object@SkylinePath
				
				# SKYD <- paste0("--in=", object@SkylineTransition)
				SKYD <- paste0("--in=", system.file("extdata/skyline.sky", package = "skylineR"))
				TRANSITIONS <- paste0("--import-transition-list=",paste(object@tempPath, "transitions.csv", sep = "/"))
				IN <- paste0("--import-file=", rawfiles[i])
				nmtp <- paste0(strsplit(basename(rawfiles[i]), "\\.")[[1]][1], ".csv")
				REPORT_NAME <- paste(object@tempPath, nmtp, sep = "/")
				REPORT_a <- paste0("--report-name=\"Transition Results\" --report-file=",REPORT_NAME, " --report-invariant")
				ANALYSE_CMD <- paste(SKYLINE,TRANSITIONS,SKYD,IN,REPORT_a, sep = " ")
				system(ANALYSE_CMD, intern = TRUE)

			}
			
			# remove transition file so from tempPath
			file.remove(paste(object@tempPath, "transitions.csv", sep = "/"))
			
			# clean .skyd temp files from system.path
			
			
			reports <- list.files(object@tempPath, pattern = ".csv", full = TRUE)
			
			if(length(reports) != length(object@filepaths)){
				message("WARNING")
			}

			report_list <- NULL
			for(i in seq_along(reports)){
				report_list[[i]] <- read.csv(reports[i], header = TRUE, stringsAsFactors = FALSE)
			}

			report_names <- gsub(".csv", "", basename(reports))
			names(report_list) <- report_names
			
			# sort duplicates out
			# // This needs handling better. For now it will do; any hopefully shouldn't be used too often //
			dups <- lapply(report_list, function(x)(duplicated(x$FragmentIon)))
			
			if(any(unlist(dups) == TRUE)){
			
				dup_ind <- lapply(dups, function(x)(which(x == TRUE)))
			
			
				dup_fragion <- NULL
				for(i in seq_along(dup_ind)){
					dup_fragion[[i]] <- report_list[[i]][dup_ind[[i]], "FragmentIon"]
				}
			
			
				dup_match <- NULL
				for(i in seq_along(dup_fragion)){
				
					ind_match <- which(report_list[[i]][,"FragmentIon"] %in% dup_fragion[[i]])
					dup_match[[i]] <- report_list[[i]][ind_match,]
				
				
				}
			
				for(i in seq_along(dup_match)){
				
					dup_match[[i]] <- split(dup_match[[i]], dup_match[[i]][,"FragmentIon"])
				}
			
			
			
				# foo <- function(x){
					# dup_match2<- NULL
					# for(i in seq_along(x)){
						# match_ind <- which(report_list[[i]][,"FragmentIon"] == x[[i]])
							# dup_match2[[i]]<- report_list[[i]][match_ind,]
					# }
					# return(dup_match2)
				# }
				
				
				
				# dup_match <- lapply(dup_fragion,foo)
			
				# dup_match <- NULL
				# for(k in seq_along(dup_fragion)){
					# for(i in seq_along(dup_fragion[[k]])){
						# match_ind <- which(report_list[[i]][,"FragmentIon"] == dup_fragion[[k]][i])
							# dup_match[[i]]<- report_list[[i]][match_ind,]
							
				# }
				# dup_match[[k]] <- dup_match[[i]]
				# dup_match[[k]] <- list(dup_match)
				
				# }
			
			
			
				foo2 <- function(x){
					dup_match <- x
					n <- NULL
					for(i in seq_along(dup_match)){
					n[i] <- nrow(dup_match[[i]])
					}
					for(i in seq_along(n)){
					if(n[i] != 2){stop("Currently only one shoulder peak is supported", call. = FALSE)}
					}
					
					for(i in seq_along(dup_match)){
					if(dup_match[[i]][1,"Area"] == dup_match[[i]][2,"Area"]){
						dup_match[[i]] <- dup_match[[i]][1,]
					
					}else{
					
					
					
					
					dup_match[[i]] <- data.frame(
					PeptideSequence = "#N/A", ProteinName = dup_match[[i]][1,"ProteinName"],
					ReplicateName = dup_match[[i]][1,"ReplicateName"],
					PrecursorMz = dup_match[[i]][1,"PrecursorMz"],
					PrecursorCharge = dup_match[[i]][1,"PrecursorCharge"],
					ProductMz = dup_match[[i]][1,"ProductMz"],
					ProductCharge = dup_match[[i]][1,"ProductCharge"],
					FragmentIon = dup_match[[i]][1,"FragmentIon"],
					RetentionTime = dup_match[[i]][which(dup_match[[i]][,"Area"] == max(dup_match[[i]][,"Area"])),"RetentionTime"],
					Area = sum(dup_match[[i]][,"Area"]),
					Background = sum(dup_match[[i]][,"Background"]),
					PeakRank = dup_match[[i]][1,"PeakRank"]
					)						
					}
				}
				return(dup_match)
				}
				
				dup_match <- lapply(dup_match, foo2)
				
				# lapply(dup_fragion, foo3)
				
				# foo3 <- function(x)
				# {
				for(i in seq_along(dup_fragion)){
				
					# for(k in seq_along(dup_fragion[[i]])){
					
						# ind_replace <- which(report_list[[i]][,"FragmentIon"] == dup_fragion[[i]])
				
				ind_replace <- which(report_list[[i]][,"FragmentIon"] %in% dup_fragion[[i]])
				
				
				
						report_list[[i]] <- report_list[[i]][-ind_replace,]
						report_list[[i]] <- rbind(report_list[[i]], do.call("rbind",dup_match[[i]]))
					}
				
					# ind_replace <- which(report_list[[i]][,"FragmentIon"] == x[i])
					# report_list[[i]] <- report_list[[i]][-ind_replace,]
					# report_list[[i]] <- rbind(report_list[[i]], dup_match[[i]])
				
				
				
				# }
				# return(report-list)
				# }
				
				
				
				
				
				
				# foo3 <- function(x,y)
				# {
				# dup_fragion <- y
				# dup_match <- x
				# for(i in seq_along(dup_fragion)){
					# ind_replace <- which(report_list[[i]][,"FragmentIon"] == dup_fragion[[i]])
					# report_list[[i]] <- report_list[[i]][-ind_replace,]
					# report_list[[i]] <- rbind(report_list[[i]], dup_match[[i]])
				# }
				# return(report_list)
				# }		
			
		
			# lapply(dup_match, function(x)(foo3(x = x, y = dup_fragion)))
			
		
		
			}
			
			result_lyt_ar <- data.frame(matrix(ncol = length(report_list) + 1, nrow = nrow(report_list[[1]])))
			names(result_lyt_ar) <- c("id",report_names)
			result_lyt_ar[,1] <- report_list[[1]][,"ProteinName"]

			for(i in seq_along(report_list)){
				result_lyt_ar[,i + 1] <- report_list[[i]][,"Area"]
			}

			result_lyt_rt <- data.frame(matrix(ncol = length(report_list) + 1, nrow = nrow(report_list[[1]])))
			names(result_lyt_rt) <- c("id",report_names)
			result_lyt_rt[,1] <- report_list[[1]][,"ProteinName"]

			for(i in seq_along(report_list)){
				result_lyt_rt[,i + 1] <- report_list[[i]][,"RetentionTime"]
			}

			result_lyt_ba <- data.frame(matrix(ncol = length(report_list) + 1, nrow = nrow(report_list[[1]])))
			names(result_lyt_ba) <- c("id",report_names)
			result_lyt_ba[,1] <- report_list[[1]][,"ProteinName"]

			for(i in seq_along(report_list)){
				result_lyt_ba[,i + 1] <- report_list[[i]][,"Background"]
			}

			peakResList <- list(area = result_lyt_ar, noise = result_lyt_ba, Rt = result_lyt_rt)

			object@peakInfo <- peakResList
			
			assign(eval(paste(text = objectName)), object, envir = .GlobalEnv)

	}
)	
