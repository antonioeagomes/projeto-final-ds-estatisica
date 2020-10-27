#Criando um vetor com os pacotes a serem instalados e importados
vetor_pacotes = c("readr", "ggplot2", "plotly", "e1071", "dplyr", "Hmisc", 
                  "DescTools", "esquisse", "gridExtra", "devtools")
install.packages(vetor_pacotes)

#Aplica o procedimento require à lista vetor_pacotes
lapply(vetor_pacotes, require, character.only = TRUE)
library(devtools)
library(readr)
library(ggplot2)
library(plotly)
library(e1071)
library(dplyr)
library(Hmisc)
library(DescTools)
library(esquisse)
library(gridExtra)

#Atribui e recupera o diretório de trabalho. Work Directory (Padrão Linux)
setwd("~/Documentos/DataScienceFB/Estatistica/projeto-final-ds-estatisica")
getwd()

#Carregando o Banco de Dados
enade_2017_table = read.table("MICRODADOS_ENADE_2017.txt", 
                              header = TRUE, 
                              sep = ";", 
                              dec = ",", 
                              colClasses = c(NT_OBJ_FG="numeric"))

enade_2017_csv = read_csv2("MICRODADOS_ENADE_2017.txt")

enade_2017_mil_linhas = head(enade_2017_table, 1000)
# write_csv(enade_2017_mil_linhas, "enade_2017_mil_linhas.csv")

#Dimensões do data frame
dim(enade_2017_mil_linhas)

#Filtragem de variaveis
enade_filtrado = dplyr::select(enade_2017_csv, CO_GRUPO, CO_REGIAO_CURSO, NU_IDADE)
View(enade_filtrado)
names(enade_filtrado)

enade_ti = filter(enade_2017_csv, CO_GRUPO == 72)
