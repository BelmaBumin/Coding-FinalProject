*preparing data for STATA
use "data/derived/merged_data.dta", clear

tabulate language

keep if language == "ENGLISH" | language == "PORTUGUESE"

*Dummies
generate English = (language == "ENGLISH")
generate Portuguese = (language == "PORTUGUESE")
generate Rock = (genre == "Rock")
generate Pop = (genre == "Pop")

*Creating a new variable
generate pop_songs = popularity * songs
generate pop_10 = popularity * 10


tabulate genre

save "data/derived/analysis_data.dta"