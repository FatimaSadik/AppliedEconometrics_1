use C:\Users\fatimasadik\Desktop\LFS2020-21.dta 
rename S4C6 age
keep if age>=10
gen literate=0
replace literate=1 if S4C81==1 & S4C82==1
label define literate 0 "literate" 1 "illiterate"
label values literate literate
tab literate [aweight=Weights]
