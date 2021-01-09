*collapse for language
use "data/derived/merged_data.dta", clear

egen lang_count = count(songs), by (language)
egen popularity_count = count(popularity), by (language)
egen popularity_mean = mean(popularity), by (language)
egen songs_mean = mean(songs), by (language)
collapse (mean) lang_count popularity_count popularity_mean songs_mean songs, by(language)

save "data/derived/collapsed_language.dta"