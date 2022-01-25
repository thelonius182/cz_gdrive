suppressPackageStartupMessages(suppressWarnings(library(googledrive)))
suppressPackageStartupMessages(suppressWarnings(library(keyring)))
suppressPackageStartupMessages(suppressWarnings(library(readxl)))
suppressPackageStartupMessages(suppressWarnings(library(yaml)))

cz_extract_sheet <- function(ss_name, sheet_name) {
  read_xlsx(ss_name,
            sheet = sheet_name,
            .name_repair = ~ ifelse(nzchar(.x), .x, LETTERS[seq_along(.x)]))
}

cz_get_url <- function(cz_ss) {
  cz_url <- paste0("url_", cz_ss)
  
  # use [[ instead of $, because it is a variable, not a constant
  paste0("https://", config$url_pfx, config[[cz_url]]) 
}

config <- read_yaml("config_nip_nxt.yaml")

# downloads GD ------------------------------------------------------------

# aanmelden bij GD loopt via de procedure die beschreven is in 
# "Operation Missa > Voortgang > 4.Toegangsrechten GD".

# Nipper-spreadsheet ophalen bij GD
path_wp_nipper_next <- paste0(config$gs_downloads, "/", "nipper_next.xlsx")
drive_download(file = cz_get_url("nipper_next"), overwrite = T, path = path_wp_nipper_next)

# sheets als df -----------------------------------------------------------

tbl_nipper_nxt_playlists <- cz_extract_sheet(path_wp_nipper_next, sheet_name = "playlists")
tbl_nipper_nxt_muw <- cz_extract_sheet(path_wp_nipper_next, sheet_name = "muziekweb")
tbl_nipper_nxt_select <- cz_extract_sheet(path_wp_nipper_next, sheet_name = "nipper-select")

# persist refactored tbles ------------------------------------------------

saveRDS(tbl_nipper_nxt_playlists, file = paste0(config$cz_rds_store, "nipper_playlists.RDS"))
saveRDS(tbl_nipper_nxt_muw, file = paste0(config$cz_rds_store, "nipper_muziekweb.RDS"))
saveRDS(tbl_nipper_nxt_select, file = paste0(config$cz_rds_store, "nipper_select.RDS"))

# finished