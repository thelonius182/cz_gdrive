# To understand this, check the documentation at "Operation Missa > Voortgang > Toegangsrechten GD".

library(googledrive)

# designate project-specific cache
options(gargle_oauth_cache = ".secrets")
# options(
#   gargle_oauth_cache = ".secrets",
#   gargle_oauth_email = TRUE
# )


# check the value of the option, if you like
gargle::gargle_oauth_cache()

# trigger auth on purpose --> store a token in the specified cache
drive_auth()
# options(gargle_quiet = FALSE)
# drive_auth(cache = ".secrets", email = TRUE)

# see your token file in the cache, if you like
list.files(".secrets/")
