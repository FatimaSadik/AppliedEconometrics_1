*8/24/24
*Fatima Sadik
*Applied Econometrics I, IBA, Karachi
ssc install bcuse // To access wooldridge datasets
help bcuse // access help for bcuse
bcuse wage1 //load wage1 data
edit // to view the datasets
br // to view the dataset in a different mode
// generate a new variable log(wage)
// for this lab assume your objective is to explore relationship between wage and education without using regression
// let's visualize the relationship through a scatter plot
twoway (scatter wage educ)
// Is the relationship positive or negative?
correlate(wage educ)
//CORRELATION IS NOT CAUSATION! But, serves as a starting point.
// descriptive stats
summarize wage
sum educ
sum wage if educ==12 // average wage for a certain slice of sample
sum educ
return list
sum wage if educ==r(max)  //max

//
help hist
hist wage
hist wage, normal
hist educ,normal

