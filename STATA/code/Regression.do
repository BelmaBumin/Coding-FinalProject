use "data/derived/analysis_data.dta", clear

* if you do not have any of the packages, below code to be used
*do install.do


drop _merge

regress popularity songs Rock English

regress songs popularity Rock English
outreg2 using "output/reg-Rock-Eng.xlsx"

regress songs popularity English, cluster(genre)
outreg2 using "output/reg-Eng-Gen.xlsx"
scatter songs popularity if language == "English"
graph save "output/lan_Eng.gph", replace
graph export "output/lan_Eng.pdf"

regress songs popularity Rock, cluster(language)
outreg2 using "output/reg-Eng-Lang.xlsx"

regress songs popularity English if genre == "Rock", robust
outreg2 using "output/reg-Eng-Rock.xlsx"
scatter songs popularity if genre == "Rock" 
graph save "output/gen_Rock.gph", replace
graph export "output/gen_Rock.pdf"

regress songs Rock English if popularity <= 1, robust
outreg2 using "output/reg-Rock-pop.xlsx"


foreach ln in songs popularity Rock English {
	generate ln`ln' = ln(`ln')
}

regress lnsongs lnpopularity lnRock lnEnglish
outreg2 using "output/lnreg-Rock-Eng.xlsx"

regress lnsongs lnpopularity lnRock lnEnglish, robust
outreg2 using "output/lnreg-Eng-Gen.xlsx"

regress lnsongs lnpopularity Rock i.songs if songs < 10, robust
outreg2 using "output/lnreg-Rock-Song10.xlsx"
scatter lnsongs popularity if songs < 10
graph save "output/song_less10.gph", replace
graph export "output/song_less10.pdf"

regress lnsongs lnpopularity Rock i.songs if songs > 500, robust
outreg2 using "output/lnreg-Rock-Song50.xlsx"
scatter lnsongs popularity if songs > 500
graph save "output/song_more500.gph", replace
graph export "output/song_more500.pdf"

foreach square in songs popularity Rock English {
	generate square`square' = sqrt(`square')
}

regress squaresongs squarepopularity squareRock squareEnglish
outreg2 using "output/sqrtreg-Rock-Eng.xlsx"
regress squaresongs squarepopularity squareRock squareEnglish, robust