#Criando um vetor com os pacotes a serem instalados e importados
vetor_pacotes = c("readr", "ggplot2", "plotly", "e1071", "dplyr", "Hmisc", 
                  "DescTools", "esquisse", "gridExtra", "devtools", "tidyverse")
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
library(psych)

# Atribui e recupera o diretório de trabalho. Work Directory (Padrão Linux)
setwd("~/Documentos/DataScienceFB/Estatistica/projeto-final-ds-estatisica")
getwd()

# Carregando o Banco de Dados
# O arquivo MICRODADOS_ENADE_2017.txt foi obtido em http://portal.inep.gov.br/microdados
# microdados_Enade_2017_portal_2018.10.09.zip
enade_2017_table = read.table("MICRODADOS_ENADE_2017.txt", 
                              header = TRUE, 
                              sep = ";", 
                              dec = ",", 
                              colClasses = c(NT_OBJ_FG="numeric"))

enade_2017_csv = read_csv2("MICRODADOS_ENADE_2017.txt")

enade_2017_mil_linhas = head(enade_2017_table, 1000)
# write_csv(enade_2017_mil_linhas, "enade_2017_mil_linhas.csv")

enade2017_filtrado= enade_2017_mil_linhas %>% filter(CO_GRUPO==2001 |CO_GRUPO==21|
                                           CO_GRUPO==5710 |CO_GRUPO==5806)

#Dimensões do data frame
dim(enade_2017_mil_linhas)

#Filtragem de variaveis
enade_filtrado = dplyr::select(enade_2017_csv, CO_GRUPO, CO_REGIAO_CURSO, NU_IDADE)
View(enade_filtrado)
names(enade_filtrado)

enade_ti = filter(enade_filtrado, CO_GRUPO == 72)
enade_ti = mutate(enade_ti, CO_REGIAO_CURSO = case_when(CO_REGIAO_CURSO == 1 ~ "Norte",
                                                           CO_REGIAO_CURSO == 2 ~ "Nordeste",
                                                           CO_REGIAO_CURSO == 3 ~ "Sudeste",
                                                           CO_REGIAO_CURSO == 4 ~ "Sul",
                                                           CO_REGIAO_CURSO == 5 ~ "Centro-Oeste") )
class(enade_ti$CO_GRUPO)
class(enade_ti$CO_REGIAO_CURSO)
s = summary(enade_2017_csv)
d = describe(enade_2017_csv)

enade_ti %>% select(CO_REGIAO_CURSO, NU_IDADE) %>% group_by(CO_REGIAO_CURSO) %>% summarise(media = mean(NU_IDADE, na.rm = T))
enade2017_sem_NA = enade_2017_csv %>% na.omit()
dim(enade2017_sem_NA)
dim(enade_2017_csv)[1] - dim(enade2017_sem_NA)[1]
fs = table(enade_filtrado$NU_IDADE)
max(fs)
nomes = names(fs)
moda = nomes[fs == max(fs)]
media = mean(enade_filtrado$NU_IDADE)
mediana = median(enade_filtrado$NU_IDADE)
moda = Mode(enade_filtrado$NU_IDADE)
qtdade = length(enade_filtrado$NU_IDADE)
consolidado = data.frame("Quantidade"=qtdade,
                         "Média"=media,
                         "Mediana"=mediana,
                         "Moda"=moda)
consolidado
skewness(enade_filtrado$NU_IDADE)
kurtosis(enade_2017_csv$NU_IDADE)