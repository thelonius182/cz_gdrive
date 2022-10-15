# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# WP-gidsweek e.a. lopen 4 weken voor op de playlistweek. Als het zenderschema
# zodanig wijzigt dat er een nieuwe versie vh modelrooster nodig is, zullen de
# scripts TIJDELIJK een afwijkende MDR-versie moeten gebruiken. Omdat cz_gdrive
# voor alle werkt, zet dit script de juiste versie-datum klaar (cmd-line
# parameter in set_mr_version_for_gdrive.bat). 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

library(readr)
library(dplyr)
library(stringr)
library(fs)

cmd_line_args <- commandArgs(trailingOnly = TRUE)

cfg_yaml <- "C:/Users/nipper/r_projects/released/cz_gdrive/config.yaml"
cfg_txt <- "C:/Users/nipper/r_projects/released/cz_gdrive/config.txt"

cfg_contents <- read_lines(file = cfg_yaml)

for (cfg_line in cfg_contents) {
  
  if (str_starts(cfg_line, "model")) {
    cfg_line <- str_replace(cfg_line, "\\d{8}", cmd_line_args[1]) 
  }
  
  write_lines(cfg_line, file = cfg_txt, append = T)
}

file_delete(cfg_yaml)
file_move(cfg_txt, cfg_yaml)
