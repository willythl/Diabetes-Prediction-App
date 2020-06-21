DiabetesApp - Prediction of Diabetes Mellitus using Machine Learning
========================================================
transition: rotate
width: 1440
height: 900
date: Sat 20 Jun 2020
css: style.css
<html>
<head>
<style>
body {
  background-image: url("http://www.seekgif.com/uploads/2017/07/light-pink-background-light-pink-backgrounds-light-pink-gradient--29.jpeg");
  background-repeat: repeat-x;
  }
</style>
</head>
<body>

<hgroup>
    <font size="9" color = "Black">Group C</font><br>
</hgroup>

<font size="7" color = "Black">Team Members Are:</font>
<ul type=&#8221;circle&#8221;>			
<li><font size="6">Robin Ahmed$\$ (17221070)</font></li>
<li><font size="6">Lee Zhen Lek$\$ (17219514)</font></li>
<li><font size="6">Avinnaash Suresh$\$ (17219903)</font></li>
<li><font size="6">Tan Hiap Li$\$ (17219269)</font></li>
</UL>	


Introduction
========================================================

### About Diabetes
Diabetes is a condition developed when human body resists or fails to make enough insulin, a hormone that helps glucose from blood to reach cells to produce energy. As a result, the glucose remains in blood and its amount increases over time resulting in Diabetes. 
In 2019, 3.6 million Malaysians had diabetes disease, highest in Asia and one of the highest in the world. An alarming 7 million adults (31.3%) aged 18 and above, both diagnosed and undiagnosed are estimated to be affected by diabetes in Malaysia by 2025.

### What do we want to achieve in this project?
Our core objective is to develop an interactive and free app by integrating machine learning model with R programming to predict if a particular observation is at risk of developing diabetes. The PIMA Indians Diabetes dataset used in this project is downloaded from Kaggle and is originally from the National Institute of Diabetes and Digestive and Kidney Diseases.

### Sample Raw DataSet:
<left>![alt text](DataSet.png)</left>

Data Downloaded from: https://www.kaggle.com/uciml/pima-indians-diabetes-database

Data Pre-processing, Visualization & Model Implementation
========================================================

### Data Pre-processing & Visualization 
<font size="5">To reach our goals of predicting diabetes from the dataset under consideration we have performed the following activities:
  * Data Cleaning
    * Detect missing value.
    * Ensure the font case for continous variable is standardized.
    * Ensure the decimal points for numeric variable is consistent.
  * Exploratory Data Analaysis
 
After data preparation and EDA,  the cleaned output was taken on which the below machine learning models were implemented using R to check the accuracy. Finally, the model with highest accuracy was picked and incorporated into DiabetesApp
</font size>   
### Model Implementation
<font size="5">  
* Implemented Models and Accuracies
    * Logistic Regression [75.32%]
    * K Nearest Neighbors (KNN) [74.03%]
    * Support Vector Machine(SVM) [74.68%]

</font>

DiabetesApp Details
========================================================

<div class='left' style='float:left;width:58%; height:100%'>
     <img src="ShinyAppFin.PNG" class="img" alt="some"/>
    </div>
    
<div class='left' style='float:left;width:40%'>
<hgroup>
    What this DiabetesApp is all about:
</hgroup>
  
<ul type=&#8221;circle&#8221;>			
<li>Overview tab shows some facts about diabetes and describes the overall functions of DiabetesApp</li>
<li>Inside HeatMap, it visualizes cases & severity in 20 Countries under International Diabetes Federation (IDF) Western Pacific Members</li>
<li>Prediction tab is the main page where you can input different parameters to predict whether you have diabetes</li>
<li>Some EDA output have been incorporated under comparison & Exploratory Data Analysis tab</li>
<li>Finally we have covered the App description in About tab </li>
</UL>		
</div>

Experience & Conclusion
========================================================

### Experience Summary

  * The experience of completing this assignment has been very enriching and empowering for each of us as we have performed as a team and presented us a wide learning opportunity.
  * Being amateurs, initially it was challenging for us to deal with Shiny App, R Packages, Slidify and R-presentation, but guidance and references helped to ease out our tasks.

### Conclusion

While we have chosen the model with higher accuracy among the ones under evaluation, yet this application is for an initial state prediction and for raising awareness beforehand. The results cannot be considered final. Therefore users are adviced to consult a physician and take necessary steps for an actual diagnosis.

* Please feel free to visit the App using: https://lekster.shinyapps.io/DiabetesApp/ 
* For sources code, go to Github link: 

<font size="10"><center>Thank You & Enjoy the App</center></font>


