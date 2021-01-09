*collapse for genre
use "data/derived/merged_data.dta", clear

egen popularity_mean_gen = mean(popularity), by (genre)
collapse (mean) popularity_mean_gen songs, by(genre)

save "data/derived/collapsed_genre.dta"