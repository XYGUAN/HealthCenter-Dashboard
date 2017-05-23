# This file is for the anlaysis of the health factors in three states: New York, Texas, Florida and Wisconsin. 
# The author is Xiuyang Guan


#####################################
##### Environment Configuration #####
#####################################
library(gdata)
library(caret)
library(rpart.plot)
library(rpart)
path <- "~/Dropbox/Xiuyang Guan"
data_input_path <- "~/Dropbox/Xiuyang Guan/Data files/Data/Excel files/This data yes/"

#########################
##### Load the data #####
#########################
original.data <- read.csv("Working_Set.csv")
tristate.data <- read.xls("tristate-area.xlsx")

##################################
##### Variable Configuration #####
##################################
output.variables <- c("YearsofPotentialLifeLostRate", "FairPoor", "PhysicallyUnhealthyDays", 
                     "MentallyUnhealthyDays", "LBW")
states.names <- c("Texas", "Connecticut", "New York", "New Jersey", "Wisconsin", "tri-state")
##############################
##### Model Construction #####
##############################

### Function to generate the models
model.generation <- function(state, model = "Tree", output){
  if(state == "tri-state"){
    model.data <- tristate.data
    model.data <- model.data[-c(1,2,3)]
    output.useless <- output.variables[!output.variables %in% output]
    model.data <- model.data[!names(model.data) %in% output.useless]
    if(model == "Tree"){
      formule <- paste(output, " ~.", sep = "")
      model <- rpart(formule, data = model.data)
      rpart.plot(model, main = paste("Tree model to split the", output, "in", state))
    }
    if(model == "CTree"){
      formule <- paste(output, " ~.", sep = "")
      model <- ctree(formule, data = model.data)
      plot(model, main = paste("Tree model to split the", output, "in", state))
    }
  }
  
  else{
    model.data <- original.data[original.data$State == state,]
    model.data <- model.data[-c(1,2,3)]
    output.useless <- output.variables[!output.variables %in% output]
    model.data <- model.data[!names(model.data) %in% output.useless]
    if(model == "Tree"){
      formule <- paste(output, " ~.", sep = "")
      model <- rpart(formule, data = model.data)
      rpart.plot(model, main = paste("Tree model to split the", output, "in", state))
    }
    if(model == "CTree"){
      formule <- paste(output, " ~.", sep = "")
      model <- ctree(formule, data = model.data)
      plot(model, main = paste("Tree model to split the", output, "in", state))
    }
  }
  
}

model.generation.error <- function(state, model = "Tree", output){
  model.data <- original.data[original.data$State == state,]
  model.data <- model.data[-c(1,2,3)]
  output.useless <- output.variables[!output.variables %in% output]
  model.data <- model.data[!names(model.data) %in% output.useless]
  if(model == "Tree"){
    formule <- paste(output, " ~.", sep = "")
    model <- rpart(formule, data = model.data)
    par(mfrow = c(2,1))
    rsq.rpart(model)
  }

}

table.condition <- function(state, condition.variable, condition.symbol, condition.value){
  model.data <- original.data[original.data$State == state,]
  model.data <- model.data[-c(1,2,3)]
  output.useless <- output.variables[!output.variables %in% output]
  model.data <- model.data[!names(model.data) %in% output.useless]
  if(condition.symbol == ">"){
    table.data.index <- which(model.data[condition.variable] > as.numeric(condition.value))
  }
  else{
    table.data.index <- which(model.data[condition.variable] < as.numeric(condition.value))
  }
  table.data <- original.data[original.data$State == state,]
  table.data <- table.data[table.data.index,]
  table.data[c("State","County",condition.variable)]
}
