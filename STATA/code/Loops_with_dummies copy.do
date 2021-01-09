*seperate the data according to Rock, Pop and Samba dummies and save the dataset seperately


use "data/derived/Dummies.dta"
 forval i = 0/1 {
        keep if Rock == `i'
		save data\derived\Rock_popularity`i'
		 
}

use "data/derived/Dummies.dta"

  forval i = 0/1 {
         keep if Pop == `i'
         save data\derived\Pop_popularity`i'
}

use "data/derived/Dummies.dta"

  forval i = 0/1 {
         keep if Rock == `i'
         save data\derived\Samba_popularity`i'
}