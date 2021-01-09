import delimited "data/raw/artists-data.csv", varnames(1) encoding(UTF-8) clear
describe

drop genres

local a `1'
local s `2'
local p `3'
local l `4'
local g `5'

label variable a "Name of the artist"
label variable s "Number of the songs artist have"
label variable p "Popularity score"
label variable l "How artist's name is written in the website"
label variable g "Artist's music genre"

duplicates list a 
duplicates report a
duplicates drop a, force

save "data/derived/artists-data-derived.dta"