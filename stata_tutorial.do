***For this exercise, we have drawn a random sample from LFS 2014-15
**Cleaning Data**
***Labeling variables
clear
use sample_lfs
label variable PROCESS_CODE "processing code"
label variable  E_B_CODE "enumeration block code"
label variable  H_H_SERIAL_NO  "Household serial number"
label variable  SURVEY_PERIOD  "survey period"
label variable  RESP_SEX  "respondent sex"
***
label define respsex 1 "Male" 2 "Female"
label values RESP_SEX respsex
***renaming variables
rename SEC4_COL5 Gender
rename SEC4_COL6 age
rename SEC4_COL11 training

label variable SEC4_COL9 "education level"
label define SEC4_COL9 1 "no formal education" 2 "nursery but <kg" 3 "K.G but <primary" ///
4 "primary but <middle" 5 "middle but <matric" 6 "matric but <intermediate" 7 "intermediate but <degree" ///
8 "degree in engineering" 9 "degree in medicine" 10 "degree in CS" 11 "degree in agriculture" 12 ///
"degree in other subjects" 13 "M.A/ M.Sc" 14 "M.Phil" 15 "Ph.D" 
label values SEC4_COL9 SEC4_COL9
rename SEC4_COL9 educ_level

*** making categories for education
gen edu=.
replace edu=0 if educ_level==1
replace edu=0 if educ_level==2
replace edu=0 if educ_level==3
replace edu=1 if educ_level==4
replace edu=2 if educ_level==5
replace edu=3 if educ_level==6
replace edu=3 if educ_level==7
replace edu=4 if educ_level==8
replace edu=4 if educ_level==9
replace edu=4 if educ_level==10
replace edu=4 if educ_level==11
replace edu=4 if educ_level==12
replace edu=5 if educ_level==13
replace edu=5 if educ_level==14
replace edu=5 if educ_level==15


label define edu 0 "no education" 1 "primary" 2 "lower sec" 3 "upper-sec" 4 "post-sec" 5 "Further studies"
label values edu edu

tabulate training
**values less than 20 represent some sort of training and equal to 20, no taining (source: LFS questionnaire)
**it is considered a good practice to generate a new variable rather than over-writing over the orignal variable
generate train=.
replace train=1 if training<20
replace train=0 if training==20
***note: . means no observation, whereas 0 is treated as an observation
label define train 1 "training" 0 "no training"
label values train train 

***Income
rename SEC5_COL17_1 total_hours_worked
label variable total_hours "total hours worked in last week"
rename SEC7_COL33 netincome_lastweek
gen wage_h=netincome_lastweek/total_hours_worked

***regression analysis****
***focus on working age population
drop if age<15 
drop if age>65
summarize age
summ age, detail
***mean age is 32 years
***check for outliers in dependent variable
***plot boxplot
graph box wage_h
**winsorize wage_h
ssc install winsor
help winsor
winsor wage_h, generate(w_hwage)p(0.05)
graph box w_hwage

**simple linear regression**
regress w_hwage age
predict yhat
predict ehat,residual
**multiple linear regression**
reg w_hwage age i.edu i.train

**robust standard-erros
reg w_hwage age i.edu i.train, robust

***getting stata output for reserach papers
ssc install outreg2
help outreg2
reg w_hwage age i.edu i.train, robust
outreg2 using myreg.doc

***testing for heteroskedasticity***
reg w_hwage age i.edu i.train
**Breusch-Pagan 
estat hettest
**white
estat imtest, white

**multicollinearity**
reg w_hwage age i.edu i.train
vif


