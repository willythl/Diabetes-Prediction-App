library(shiny)
library(shinydashboard)
library(base)
library(shinyBS)
library(ECharts2Shiny)
library(leaflet)
library(leaflet.extras)
library(htmltools)
library(readxl)
library(stringr)
library(lubridate)
library(plotly)
library(ECharts2Shiny)
library(DT)
library(expss)
library(e1071)
library(rvest)
library(quantmod)
library(rsconnect)
library(dplyr)
library(ggplot2)



#================================== Overview UI ==================================#

oTitle <- fluidRow(
  column(width = 12,
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "DiabetesApp"))), style = "font-size:1.8em",align = "center"),
  ))
oSource <- fluidRow(
  column(width = 12,
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "Source:"))),
           style = "font-size:1.0em",align='left'),
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "https://www.diabetesresearch.org/diabetes-statistics"))),
           style = "font-size:1.0em",align='left'),
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "https://www.nst.com.my/news/nation/2019/03/473136/close-1-3-adults-diabetic-2025-says-health-minister"))),
           style = "font-size:1.0em",align='left'),
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "https://aspe.hhs.gov/report/diabetes-national-plan-action/importance-early-diabetes-detection"))),
           style = "font-size:1.0em",align='left'),
  )
)
oInfo <- fluidRow(
  column(width =12,
         tags$div(
           HTML(paste("In 2019, ",
                      tags$span(style="font-weight:bold; color:#337a87", "3.6 million Malaysians "),
                      "had diabetes disease, ",
                      tags$span(style="font-weight:bold; color:#337a87", "highest in Asia "),
                      " and ",
                      tags$span(style="font-weight:bold; color:#337a87", "one of the highest in the world."),
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("An alarming  ", 
                      tags$span(style="font-weight:bold; color:#337a87", "7 million adults (31.3%) "),
                      "aged 18 and above, both diagnosed and undiagnosed are estimated to be affected by ",
                      tags$span(style="font-weight:bold; color:#337a87", "diabetes in Malaysia by 2025."),
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("A macro-economic study done in 2011 showed that diabetes cost the country approximately ", 
                      tags$span(style="font-weight:bold; color:#337a87", "RM2 billion, "),
                      " potentially representing ",
                      tags$span(style="font-weight:bold; color:#337a87", "13%"),
                      " healthcare budget for year 2011. ",
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste( tags$span(style="font-weight:bold; color:#337a87", "Early diagnosis of diabetes and pre-diabetes "),
                       "is important so that patients can begin to manage the disease early and potentially prevent or delay the serious disease complications that can decrease quality of life. "))
           ,style = "font-size:1.2em"), 
         hr(style = "border-color:white;margin-bottom:0.25em"), 
         
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#337a87", "DiabetesApp, "),
                      "able to predict if a person is having diabetes by using Machine Learning and without visiting clinic or hospital.",
                      sep = "")), style = "font-size:1.2em"
         ),
         hr(style = "border-color:white;margin-bottom:0.25em"), 
         tags$div(
           HTML(paste("User only needs to provide information such as ",
                      tags$span(style="font-weight:bold; color:#337a87", "age, glucose level, skin thickness, Insulin, BMI, Diabetes Pedigree Function. "),
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
  ))




#================================== Heatmap UI ==================================#

data<- read.csv("IDF_diabetes.csv")

data$Severity <- ifelse(data$Diabetes < 0.05, "Low", 
                        ifelse(data$Diabetes <= 0.1 | data$Diabetes >=0.05, "Intermediate",
                               ifelse(data$Diabetes > 0.1, "High")))

hTitle <- fluidRow(
  column(width = 12,
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "Diabetes Statistics - 20 Countries under International Diabetes Federation (IDF) Western Pacific Members"))),
           style = "font-size:1.8em",align = "center"),
  )
)

hInfo <- fluidRow(
  column(width = 12,
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "Data Source: https://idf.org/our-network/regions-members/western-pacific/members.html"))),
           style = "font-size:1.0em",align='center'),
  )
)
hInfo2 <- fluidRow(
  column(width = 12,
         tags$div(
           HTML(paste(tags$span(style="font-weight:bold; color:#12454f", "Data Date: 14/05/2020"))),
           style = "font-size:1.0em",align='center'),
  )
)
hMap <- leafletOutput(outputId = "mymap", height=700, width=1500)

#this allows me to put the checkmarks ontop of the map to allow people to view diabetes severity or overlay a heatmap
hMap2<- absolutePanel(top = 600, left = 300, 
                      checkboxInput("markers", "Severity", FALSE),
                      checkboxInput("heat", "Cases", FALSE)
)


#================================== Prediction UI ==================================#

diabetes <- read.csv("diabetes.csv")
diabetes$diagnostic<-diabetes$Outcome
diabetes$diagnostic[diabetes$diagnostic==0] = 'No'
diabetes$diagnostic[diabetes$diagnostic==1] = 'Yes'


pInfo <- fluidRow(
  column(width = 4, 
         
         sliderInput(inputId = "Pregnancies", 
                     label = "No of Pregnancies : ", 
                     value = 0, min=min(diabetes$Pregnancies),max=max(diabetes$Pregnancies), step = 1
         ),
         sliderInput(inputId = "Glucose", 
                     label = "Glucose level : ", 
                     value = 1, min=min(diabetes$Glucose) ,max=max(diabetes$Glucose)
         ),
         sliderInput(inputId = "BloodPressure",
                     label = "Blood Pressure(mmHg) : ",
                     value = 1, min=min(diabetes$BloodPressure), max=max(diabetes$BloodPressure)
         ),
         sliderInput(inputId = "SkinThickness",
                     label = "Skin Thickness(mm) : ",
                     value = 1, min=min(diabetes$SkinThickness), max=max(diabetes$SkinThickness)
         )),
  column(width = 4,
         
         sliderInput(inputId = "Insulin",
                     label = "Insulin (muU/ml) : ",
                     value = 1, min=min(diabetes$Insulin), max=max(diabetes$Insulin)
         ),
         sliderInput(inputId = "BMI",
                     label = "Body Mass Index(BMI) : ",
                     value = 1, min=min(diabetes$BMI), max=max(diabetes$BMI),step = 0.5
         ),
         sliderInput(inputId = "DiabetesPedigreeFunction",
                     label = "Diabetes Pedigree Function : ",
                     value = 1, min=min(diabetes$DiabetesPedigreeFunction), max=max(diabetes$DiabetesPedigreeFunction),step = 0.01
         ),
         sliderInput(inputId = "Age",
                     label = "Age : ",
                     value = 1, min=min(diabetes$Age),max=max(diabetes$Age), step = 1
         )),
  
  column( width = 4,
          actionButton("refresh",label = "RUN"),
          tableOutput('finaltable'),
          valueBoxOutput('ibox', width = 12)
          
  )
  
)

#================================== Comparison UI ==================================#
cInfo <- sidebarLayout( 
  sidebarPanel (width = 4,
                radioButtons('p', 'Select column of independant variable:', 
                             list('Pregnancies'='a', 'Glucose'='b', 'BloodPressure'='c',
                                  'SkinThickness' = 'd', 'Insulin'='e', 'BMI'='f',
                                  'DiabetesPedigreeFunction' = 'g', 'Age'='h'))),
  
  mainPanel(width = 8,
            plotOutput('cplot'))
  
)

#================================== EDA UI ==================================#
eInfo<- sidebarLayout(
  sidebarPanel( width = 4,
                radioButtons('q', 'Select column of independant variable:', 
                             list('Pregnancies'='a1', 'Glucose'='b1', 'BloodPressure'='c1',
                                  'SkinThickness' = 'd1', 'Insulin'='e1', 'BMI'='f1',
                                  'DiabetesPedigreeFunction' = 'g1', 'Age'='h1'))
  ),
  mainPanel(width = 8,
            plotOutput('eplot')
            
  )
)


#================================== About UI ==================================#

aInfo <- fluidRow(
  column(width =12,
         tags$div(
           HTML(paste("1. This application would evaluate if an individual has diabetes based on several physiological attributes.",
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("2. User selects their health attributes, age, number of pregnancy, glucose level, blood pressure, skin thickness, insulin level, BMI and diabetes pedigree function.", 
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("3. Once information are given, predictive model will be used to predict if user has diabetes disease.",
                      sep = "")), style = "font-size:1.2em"
         ),hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("4. The result is based on machine learning technique and will not be 100% accurate.
                               Therefore, user is recommended to consult doctor or perform a proper check up in hospital or clinic if result shows positive in prediction."))
           ,style = "font-size:1.2em"), 
         hr(style = "border-color:white;margin-bottom:0.25em"),
         
         tags$div(
           HTML(paste("5. User can compare their condition with the data set that used to train the predictive model in the Comparison tab."))
           ,style = "font-size:1.2em"), 
         hr(style = "border-color:white;margin-bottom:0.25em"), 
         
         tags$div(
           HTML(paste("6. Exploratory Data Analysis tab shows the trend of each attributes with or without diabetes."))
           ,style = "font-size:1.2em"), 
         hr(style = "border-color:white;margin-bottom:0.25em"), 
         
         tags$div(
           HTML(paste("Disclaimer: This dataset is retrieved from Kaggle and originally from the National Institute of Diabetes and Digestive and Kidney Diseases."))
           ,style = "font-size:1.2em"), 
         hr(style = "border-color:white;margin-bottom:0.25em"), 
  )
)         




#================================== Combined UI ==================================#

ui <- dashboardPage(
  dashboardHeader(title = 'DiabetesApp'),
  
  
  # dashboard Sidebar 
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview",tabName = 'overview',icon=icon("poll")),
      menuItem("Heatmap",tabName='heatmap',icon=icon("globe")),
      menuItem("Prediction",tabName='prediction',icon=icon('male')),
      menuItem('Comparison', tabName = 'comparison', icon = icon('chart-bar')),
      menuItem('Exploratory Data Analysis', tabName = 'eda', icon = icon('chart-bar')),
      menuItem("About",tabName='about',icon=icon('question-circle'))
    )
  ),
  
  #dashboard body
  dashboardBody(
    tabItems(
      tabItem(tabName='overview',
              tabBox(title=strong('Overview'),
                     id = 'tabO', height = '33em', width='1em',
                     tabPanel('',oTitle,hr(),oInfo,hr(),hr(),oSource)
              )
      ),
      tabItem(tabName='heatmap',
              tabBox(title=strong('Heatmap'),
                     id = 'tabh',height='55em',width='1em',
                     tabPanel('',hTitle,hr(),hMap,hMap2,hr(),hInfo,hr(),hInfo2)
              )
      ),
      tabItem(tabName='prediction',
              tabBox(title=strong('Diabetes Prediction'),
                     id='tabp',height='55em',width='1em',
                     tabPanel('',pInfo)
              )
      ),
      # add another tab 23/5/2020, where a user stand compared to the data
      tabItem(tabName = 'comparison',
              tabBox(title = strong('Comparison'),
                     id='tabc', height = '55em', width = '1em',
                     tabPanel('',cInfo)
              )
      ),
      #add another tab 25/5/2020, for eda
      tabItem(tabName = 'eda',
              tabBox(title = strong('Exploratory Data Analysis'),
                     id='tabe', height = '55em', width = '1em',
                     tabPanel('',eInfo)
              )
      ),
      tabItem(tabName='about',
              tabBox(title=strong('About'),
                     id='tabA',height = '33em',width='1em',
                     tabPanel('',aInfo)))
    )
  )
)







#================================== Combined Server ==================================#

server <- function(input, output, session) {
  #define the color pallate for the diabetes
  pal <- colorNumeric(
    palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
    domain = data$Diabetes)
  
  #define the color of for the depth of the earquakes
  pal2 <- colorFactor(
    palette = c('blue', 'yellow', 'red'),
    domain = data$Severity
  )
  
  #create the map
  labs <- lapply(seq(nrow(data)), function(i) {
    paste0( '<p>', data[i, "Countries"], '</p><p>', 
            'Adult Population : ', data[i, "Adult.population"], '</p><p>', 
            'Adult Diabetes : ', data[i, "Diabetes"]*100,'%','</p><p>', 
            'Adult Diabetes Cases : ',data[i, "Cases"], '</p>' ) 
  })
  output$mymap <- renderLeaflet({
    leaflet(data) %>% 
      setView(lng = 120, lat = 10, zoom = 3)  %>% #setting the view over
      addTiles() %>% 
      addCircles(lat = ~ Latitude, lng = ~ Longitude, 
                 weight = 1, radius = ~sqrt(Diabetes*100)*25000, 
                 label = lapply(labs,htmltools::HTML),
                 color = ~pal(Diabetes), fillOpacity = 0.5)
  })
  
 
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$markers) {
      proxy %>% 
        addCircleMarkers(stroke = FALSE, color = ~pal2(Severity), fillOpacity = 0.2) %>%
        leaflet::addLegend("bottomright", pal = pal2, values = data$Severity,
                  title = "Diabetes Severity",
                  opacity = 1)}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = data)
    proxy %>% clearMarkers()
    if (input$heat) {
      proxy %>%  addHeatmap(lng=~Longitude, lat=~Latitude, 
                            intensity = ~Diabetes, blur =  10, 
                            max = 0.05, radius = 15) 
    }
    else{
      proxy %>% clearHeatmap()
    }
    
  })
  #===========Parameter table for prediction ===================
  output$finaltable<-renderTable({
    
    table_title<-c('Pregnancies','Glucose','Blood pressure','Skin Thickness','Insulin','BMI','Diabetes Pedigree','Age')
    
    table_content<-c(input$Pregnancies, input$Glucose, input$BloodPressure, input$SkinThickness, input$Insulin, input$BMI,input$DiabetesPedigreeFunction,input$Age)
    
    df<-data.frame('Parameters'= table_title,'Readings'= table_content)
    df
  },rownames = FALSE)
  
  #===========Machine learning model for prediction=============
  
  #Import dataset, this will directly be the training set, no splitting necessary
  training_set <- read.csv("diabetes.csv")
  
  
  input_data= eventReactive(input$refresh, {
    data= data.frame(      Pregnancies = input$Pregnancies,
                           Glucose = input$Glucose,
                           BloodPressure = input$BloodPressure,
                           SkinThickness = input$SkinThickness,
                           Insulin = input$Insulin,
                           BMI = input$BMI,
                           DiabetesPedigreeFunction = input$DiabetesPedigreeFunction ,
                           Age = input$Age
    )
    #data = scale(data)
    
    
    return(data)
  })
  
  # testtt<-data.frame(      Pregnancies = 0,
  #                        Glucose = 4,
  #                        BloodPressure = 7,
  #                        SkinThickness = 8,
  #                        Insulin = 0,
  #                        BMI = 5,
  #                        DiabetesPedigreeFunction = 6 ,
  #                        Age = 7
  #)
  # input_data = eventReactive(input$refresh,{
  #   data = data.frame('Pregnancies'=input$Pregnancies,
  #                     'Glucose'=input$Glucose,
  #                     'BloodPressure'=input$BloodPressure,
  #                     'SkinThickness'=input$SkinThickness,
  #                     'Insulin'=input$Insulin,
  #                     'BMI'=input$BMI,
  #                     'DiabetesPedigreeFunction'=input$DiabetesPedigreeFunction,
  #                     'Age'=input$Age)
  #   
  #   return(data)
  # })
  
  #filter dataset
  training_set<-training_set %>%
    filter(Glucose >0 & BloodPressure >25 & SkinThickness >0 & Insulin >0 & BMI >0 )
  
  #encoding target feature as factor
  training_set$Outcome<-as.factor(training_set$Outcome)
  
  #Feature Scaling
  #training_set[-9] = scale(training_set[-9])
  # input_data = scale(input_data)
  
  #Fitting logistic regression model with the dataset
  # classifier = glm(formula = Outcome~.,
  #                  family = binomial,
  #                  data = training_set)
  
  #classifier = train(Outcome~., data = training_set, method = 'glm', family = 'binomial')
  
  #Model prediction
  library(class)
  final_prediction = eventReactive(input$refresh, {
    #input_df = scale(input_data)
    
    #prob_pred = predict(classifier,input_data(), type = 'response' ) #make sure to include the bracket () after the dataset 
    prob_pred = knn(train = training_set[-9], 
                    test = input_data(), cl = training_set[,9],
                    k = 60, prob = TRUE )
    
    #names(prob_pred) = c('No', 'Yes')
    #prob_pred = prob_pred %>% mutate(Outcome = ifelse(No > Yes, 'NO', 'YES'),
    # No = paste0(round((No*100),2),'%'),
    # Yes = paste0(round((Yes*100),2),'%'))
    
    #prob_pred = ifelse(prob_pred >= 0.5, 'YES','NO') 
    return(prob_pred)
  })
  
  output$ibox = renderValueBox({
    valueBox(
      "Prediction:", ifelse( final_prediction()=='1', yes = 'YES', no = if(final_prediction()=='0'){'NO'}), color = ifelse(final_prediction() == '1', 'red','green')
    )
  })
  # output$ibox2 = renderValueBox({
  #   valueBox(
  #     ifelse(final_prediction() >= 0.5, 'YES','NO'), "test?", color = 'orange'
  #   )
  # })
  # output$ibox3 = renderValueBox({
  #   valueBox(
  #     final_prediction()[1], "test", color = 'orange'
  #   )
  # })
  
  
  
  #============plotting chart for comparison====================
  output$cplot<- renderPlot({
    
    i=1
    if(input$p=='a'){i<-1
    n ='Pregnancies'
    y_patient<-input$Pregnancies}
    
    if(input$p=='b'){i<-2
    n = 'Glucose'
    y_patient<-input$Glucose}
    
    if(input$p=='c'){i<-3
    n = 'BloodPressure'
    y_patient<-input$BloodPressure}
    
    if(input$p=='d'){i<-4
    n = 'SkinThickness'
    y_patient<-input$SkinThickness}
    
    if(input$p=='e'){i<-5
    n = 'Insulin'
    y_patient<-input$Insulin}
    
    if(input$p=='f'){i<-6
    n = 'BMI'
    y_patient<-input$BMI}
    
    if(input$p=='g'){i<-7
    n = 'DiabetesPedigreeFunction'
    y_patient<-input$DiabetesPedigreeFunction}
    
    if(input$p=='h'){i<-8
    n = 'Age'
    y_patient<-input$Age}
    
    x<-diabetes$diagnostic
    y<-diabetes[,i] #comma is needed here
    
    new_df<-data.frame(x = x, y = y) 
    
    
    ggplot(new_df, aes(x = x, y = y))+
      theme_bw()+
      geom_violin(aes(fill=x))+
      guides(fill = guide_legend(title = 'diagnostic'))+
      labs(
        y = 'count',
        x = 'Outcome',
        title = n
      )+
      xlab('diagnostic')+
      geom_hline(aes(yintercept = y_patient), color='green')
  })
  
  #================plot chart for Exploratory Data Analysis=====================
  
  output$eplot<- renderPlot({
    
    if(input$q=='a1'){
      #pregnancies
      # diabetes %>%
      # filter(SkinThickness >0 & SkinThickness< 75)%>%
      g<-ggplot(diabetes,aes(x =Pregnancies, fill = diagnostic)) +
        geom_bar()
      
    }
    
    if(input$q=='b1'){
      #glucose level
      #diabetes %>%
      #filter(Glucose >0 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      diabetes<-filter(diabetes, Glucose >0)
      g<- ggplot(diabetes, aes(x =Glucose, fill = diagnostic)) +
        geom_histogram(binwidth = 5)
    }
    
    if(input$q=='c1'){
      #blood pressure level
      #diabetes %>%
      # filter(BloodPressure >25 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      diabetes<-filter(diabetes, BloodPressure >25)
      g<-ggplot(diabetes,aes(x =BloodPressure, fill = diagnostic)) +
        geom_histogram()
    }
    
    if(input$q=='d1'){
      #skin thickness
      #diabetes %>%
      #filter(SkinThickness >0 & SkinThickness<75 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      diabetes<-filter(diabetes, SkinThickness >0 & SkinThickness<75)
      g<-ggplot(diabetes,aes(x =SkinThickness, fill = diagnostic)) +
        geom_histogram()
    }
    
    if(input$q=='e1'){
      #insulin
      # diabetes %>%
      #filter(Insulin >0 & SkinThickness<750 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      diabetes<-filter(diabetes, Insulin >0)
      g<-ggplot(diabetes,aes(x =Insulin, fill = diagnostic)) +
        geom_histogram(binwidth = 30)
    }
    
    if(input$q=='f1'){
      #BMI
      #diabetes %>%
      #filter(BMI >0 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      diabetes<-filter(diabetes, BMI >0)
      g<-ggplot(diabetes,aes(x =BMI, fill = diagnostic)) +
        geom_histogram(binwidth = 2)
    }
    
    if(input$q=='g1'){
      #diabetes pedigree function
      #diabetes %>%
      #filter( >0 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      g<-ggplot(diabetes,aes(x =DiabetesPedigreeFunction, fill = diagnostic)) +
        geom_histogram(binwidth = 0.05)
    }
    
    if(input$q=='h1'){
      #age
      #diabetes %>%
      #filter( >0 )%>%
      #sapply(Glucose, function(x)median(x))%>%
      g<-ggplot(diabetes,aes(x =Age, fill = diagnostic)) +
        geom_bar()
    }
    g
    
    #diabetes %>%
    # ggplot(aes(x=Age, y = BloodPressure, color = diagnostic)) +
    #geom_point(aes(size=BMI), alpha = 0.5)
    
    
  })
  
}


shinyApp(ui,server)

