library(readr)
library(tidyverse)
library(readxl)

OEM <- read_excel("OEM.xlsx")
Characteristics <- read_excel("Characterisitcs.xlsx")

names(OEM) <- make.names(names(OEM), unique=TRUE)
names(Characteristics) <- make.names(names(Characteristics), unique=TRUE)

mydata <- merge(OEM, Characteristics, by.x=c("Manufacturer.Name","System.Model.Number","Coil.Model.Number.1"), by.y=c("Company","Model.Number","Coil.Model.Number"))
