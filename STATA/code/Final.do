
*cd FerideBelmaBumin-Final-Project

import delimited "data/raw/artists-data.csv", varnames(1) encoding(UTF-8) clear
describe

drop genres

label variable artist "Name of the artist"
label variable songs "Number of the songs artist have"
label variable popularity "Popularity score"
label variable link "How artist's name is written in the website"
label variable genre "Artist's music genre"

duplicates list artist 
duplicates report artist
duplicates drop artist, force

save "data/derived/artists-data-derived.dta"

import delimited "data/raw/lyrics-data.csv", varnames(1) encoding(UTF-8) clear

/*import delimited "artists-data.csv", varnames(1) bindquote(strict) encoding(UTF-8) clear &
import delimited "artists-data.csv", varnames(1) bindquote(nobind) encoding(UTF-8) clear

codes did not solve my problem. Therefore, I decided to delete all Lyrics column because I do not need this column in my project.*/

drop lyric

label variable alink "How artist's name is written in the website" 
label variable sname "Name of the song"
label variable slink "URL of the song"
label variable idiom "Language of the song"

*data cleaning
tabulate idiom, missing
drop if idiom == "NA"
drop if idiom == ""
rename idiom language

save "../data/derived/lyrics-data-derived.dta"


*to merge
use "data/derived/lyrics-data-derived.dta", clear

rename alink link
merge m:1 link using "data/derived/artists-data-derived.dta"
keep if _merge==3


*data cleanin after merge
duplicates drop artist, force
drop slink link sname 

save "data/derived/merged_data.dta"

*collapse for language
use "data/derived/merged_data.dta", clear

egen lang_count = count(songs), by (language)
egen popularity_count = count(popularity), by (language)
egen popularity_mean = mean(popularity), by (language)
egen songs_mean = mean(songs), by (language)
collapse (mean) lang_count popularity_count popularity_mean songs_mean songs, by(language)

save "data/derived/collapsed_language.dta"

*collapse for genre
use "data/derived/merged_data.dta", clear
egen popularity_mean_gen = mean(popularity), by (genre)
collapse (mean) popularity_mean_gen songs, by(genre)

save "data/derived/collapsed_genre.dta"

*preparing data for STATA
use "data/derived/merged_data.dta", clear

tabulate language
keep if language == "ENGLISH" | language == "PORTUGUESE"


generate English = (language == "ENGLISH")
generate Portuguese = (language == "PORTUGUESE")
generate pop_songs = popularity * songs


tabulate genre



*egen language_count = count(language), by (songs)

forvalues i=100/246 {
	mean songs if popularity >= `i'
}

forvalues i=100/246 {
	mean songs if popularity >= `i'
}




*collapse (count) genre, by(language)

*collapse (mean) popularity_mean lang_count popularity_count, by(genre)

*reshape wide music, i(popularity_mean) j(popularity_mean_gen)

*collapse (mean) popularity_mean, by(language)
*sort language 
*collapse (mean) popularity_mean_gen, by(genre)
*sort genre




*Creating dummy variables for the songs in English and Portuguese



*keep if language == "ENGLISH" & "PORTUGUESE"

*summarize popularity_mean, detail
*drop if popularity_mean ==0
*count if language == "ENGLISH"
*keep if language == "ENGLISH"

*collapse (mean) popularity_mean lang_count popularity_count, by(language)