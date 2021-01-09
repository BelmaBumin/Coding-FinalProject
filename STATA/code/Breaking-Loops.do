*cd FerideBelmaBumin-Final-Project

import delimited "data/raw/artists-data.csv", varnames(1) encoding(UTF-8) clear

*summarize artists with popularity score bigger than 10 
local mostpopular 10
local variable popularity

summarize `songs' if popularity >= `mostpopular'

*summarize artists with popularity score bigger than 40 
local mostpopular 40
local variable popularity

summarize `songs' if popularity >= `mostpopular'

*summarize artists with popularity score bigger than 100 
local mostpopular 100
local variable popularity

summarize `songs' if popularity >= `mostpopular'

*generate variable
local apopularity popularity   
local B 10   

generate spopularity = `apopularity'*`B'

*loops  
forvalues i=0/1 {
	summarize songs if popularity >= `i'
	display 
}

forvalues i=1/2 {
	summarize songs if popularity >= `i'
	display 
}

forvalues i=2/3 {
	summarize songs if popularity >= `i'
	display 
}


forvalues i=3/4 {
	summarize songs if popularity >= `i'
	display 
}

*Loop with Dummies
generate Rock = (genre == "Rock")
generate Pop = (genre == "Pop")
generate HipHop = (genre == "Hip Hop")
generate FunkCarioca = (genre == "Funk Carioca")
generate Sertanejo = (genre == "Sertanejo")
generate Samba = (genre == "Samba")

forvalues i=0/1 {
	summarize popularity if Rock >= `i'
	summarize popularity if Pop >= `i'
	summarize popularity if HipHop >= `i'
	summarize popularity if FunkCarioca >= `i'
	summarize popularity if Sertanejo >= `i'
	summarize popularity if Samba >= `i'
}

save "data/derived/Dummies.dta"

*seperate the data according to Rock, Pop and Samba dummies and save the dataset seperately

do code\Loops_with_dummies.do
