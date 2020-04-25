library(xml2)
library(magrittr)

fix_xml <- function(projekt_dir){
  error_log <- file.path(projekt_dir, "error.log")
  if(file.exists(error_log) == TRUE) file.remove(error_log)
  folders <- list.dirs(file.path(projekt_dir, "tei"), recursive = FALSE)
  for(folder in folders){
    print(folder)
    lapply(list.files(folder, full.names = TRUE), function(file){
      tryCatch(a1 <- xml2::read_xml(file),
               error = function(e){
                 print(file)
                 'con <- file(description = file)
               fix_to_write <- readLines(con) %>%
                 gsub("&", "und", .) %>%
                 gsub("<<", "<", .) %>%
                 gsub(">>", ">", .) %>%
                 gsub(">< ", ">", .) %>%
                 gsub(" ><", "<", .) %>%
                 gsub("<7i>|< b>|<7I>|<-2>|<\\(i>|<7b>|<7b>|>>>|<<<", "", .)
               close(con)'
                 #writeLines(fix_to_write, file)
                 write(file, error_log, append = TRUE)
               })
    })
  }
}

fix_xml("/Users/simgeh/lab/_temp/DieZeit")