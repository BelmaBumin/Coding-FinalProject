*to merge
use "data/derived/lyrics-data-derived.dta", clear

rename alink link
merge m:1 link using "data/derived/artists-data-derived.dta"
keep if _merge==3


*data cleanin after merge
duplicates drop artist, force
drop slink link sname 

save "data/derived/merged_data.dta"