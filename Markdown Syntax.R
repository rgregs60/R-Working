
tinytex::install_tinytex()

tinytex:::is_tinytex()

library(rmarkdown)

#---
#title: "BUAN 244 - Fall 2023 - Assignment"
#author: "BUAN Department"
#date: "`r Sys.Date()`"
#output: html_document
#---
  
  
  # Introduction
  
#  This is a sample R Markdown document.

setwd("K:/BUAN 244 Business Analysis 2/BUAN 244 - In-Class Assignments/Assignment #1")
      
getwd()

render("K:/BUAN 244 Business Analysis 2/R Working Directory/Assignment 1 - Class Review R Cleaning Steps Rev 9-4 Update.Rmd", output_format = "html_document")

