library(httr)
library(utils)
link = "ftp://ftp.nhtsa.dot.gov/fars/"
years = 1975:2015

all_links = paste0(link, years, "/DBF/",
    "FARS", years, ".zip")
df = data.frame(
    path =  dirname(all_links),
    file = basename(all_links),
    year = years,
    stringsAsFactors = FALSE)
change = df$year >= 1994 & df$year <= 2000
df$file[ change ] = paste0(
    "FARSDBF", 
    sprintf("%02.0f", 
        df$year[ change ] %% 100), 
    ".zip")

# change = df$year >= 2001 
# df$file[ change ] = paste0(
#     "FARS", 
#     df$year[ change] ,
#     ".zip")

change = df$year == 2012 
df$path[ change ] = paste0(
    dirname(df$path[ change]),
    "/National/",
    "DBF")

change = df$year >= 2013 & df$year <= 2015
df$path[ change ] = paste0(
    dirname(df$path[ change]),
    "/National/")
df$path[ change ] = paste0(
    dirname(df$path[ change]),
    "/National/")
df$file[ change ] = paste0(
    "FARS", 
    df$year[ change ],
    "NationalDBF.zip")

all_links = paste0(df$path, "/", df$file)
all_links

inds = seq_along(all_links)
inds = 39:length(all_links)
for (ilink in inds) {
    print(ilink)
    tmp = tempfile(fileext = ".zip")
    req <- httr::GET(all_links[ilink],
        httr::write_disk(path = tmp))
    #############################
    # Download the data to a temporary file
    # Change outdir to the directory for the
    # DBF files
    #############################    
    outdir = tempfile()
    dir.create(outdir)
    #####################################
    # Unzip the files 
    # uz will contain the filenames
    ####################################
    uz = unzip(tmp, exdir = outdir)
}

