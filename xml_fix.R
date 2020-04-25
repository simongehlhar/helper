library(xml2)
library(magrittr)
folders <- list.dirs("/Volumes/data/polmine/welt/xml_out", recursive = FALSE)
#folders <- folders[47:length(folders)]
for(folder in folders){
  print(folder)
  lapply(list.files(folder, full.names = TRUE), function(file){
    tryCatch(a1 <- xml2::read_xml(file),
             error = function(e){
               print(file)
               file_to_open <- file(file)
               fix_to_write <- readLines(file_to_open) %>%
                 gsub("&", "und", .) %>%
                 gsub("<<", "<", .) %>%
                 gsub(">>", ">", .) %>%
                 gsub(">< ", ">", .) %>%
                 gsub(" ><", "<", .) %>%
                 gsub("<7i>|< b>|<7I>|<-2>|<\\(i>|<7b>|<7b>|>>>|<<<", "", .)
               writeLines(fix_to_write, file_to_open)
               close(file_to_open)
               write(file, "/Users/simgeh/error.txt", append = TRUE)
             })
  })
}
