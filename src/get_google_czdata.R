library(googledrive)
library(keyring)
library(readxl)

cz_extract_sheet <- function(ss_name, sheet_name) {
  read_xlsx(ss_name,
            sheet = sheet_name,
            .name_repair = ~ ifelse(nzchar(.x), .x, LETTERS[seq_along(.x)]))
}

cz_get_url <- function(cz_ss) {
  cz_url <- paste0("url_", cz_ss)
  paste0("https://", config$url_pfx, config[[cz_url]])
}

config <- read_yaml("config.yaml")

# downloads GD ------------------------------------------------------------

# aanmelden bij GD
drive_auth(path = key_get(service = "cz-sheets-processing", username = "access-token"))

# Roosters 3.0 ophalen bij GD
path_roosters <- paste0(config$gs_downloads, "/", "roosters.xlsx")
drive_download(file = cz_get_url("roosters"), overwrite = T, path = path_roosters)

# iTunes-cupboard ophalen bij GD
path_itunes_cupboard <- paste0(config$gs_downloads, "/", "itunes_cupboard.xlsx")
drive_download(file = cz_get_url("itunes_cupboard"), overwrite = T, path = path_itunes_cupboard)

# WP-gids-info ophalen bij GD
path_wp_gidsinfo <- paste0(config$gs_downloads, "/", "wordpress_gidsinfo.xlsx")
drive_download(file = cz_get_url("wordpress_gidsinfo"), overwrite = T, path = path_wp_gidsinfo)

# sheets als df -----------------------------------------------------------

tbl_presentatie <- cz_extract_sheet(path_roosters, sheet_name = "presentatie")
tbl_montage <- cz_extract_sheet(path_roosters, sheet_name = "montage")
tbl_zenderschema <- cz_extract_sheet(path_roosters, sheet_name = paste0("modelrooster-", config$modelrooster_versie))
tbl_itunes_cupboard <- cz_extract_sheet(path_itunes_cupboard, sheet_name = "playlist_names")
tbl_gidsinfo <- cz_extract_sheet(path_wp_gidsinfo, sheet_name = "gids-info")
tbl_gidsinfo_nl_en <- cz_extract_sheet(path_wp_gidsinfo, sheet_name = "vertalingen NL-EN")
