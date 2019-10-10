library(googlesheets4)
library(googledrive)
library(keyring)

drive_auth(path = key_get(service = "cz-sheets-processing", username = "access-token"))
drive_find("cup")
drive_download(file = as_id("10ZlUGqnG_yWGAgVYx7k6XD_i5BD9K2OUi2NJXu0E_Gc"))
