import delimited "data/raw/lyrics-data.csv", varnames(1) encoding(UTF-8) clear

/*import delimited "artists-data.csv", varnames(1) bindquote(strict) encoding(UTF-8) clear &
import delimited "artists-data.csv", varnames(1) bindquote(nobind) encoding(UTF-8) clear

codes did not solve my problem. Therefore, I decided to delete all Lyrics column because I do not need this column in my project.*/

drop lyric

local a `1'
local sn `2'
local sl `3'
local i `4'


label variable a "How artist's name is written in the website" 
label variable sn "Name of the song"
label variable sl "URL of the song"
label variable i "Language of the song"

*data cleaning
tabulate i, missing
drop if i == "NA"
drop if i == ""
rename i language

save "data/derived/lyrics-data-derived.dta"