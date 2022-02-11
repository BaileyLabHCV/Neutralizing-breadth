library(lsei)
library(xlsx)
library(tidyverse)

rankVectorAbMatrix <-readxl::read_excel("~/Desktop/DeconvInput.xlsx", sheet = 1)
num_Abs <- dim(rankVectorAbMatrix)[2]
strains <-rankVectorAbMatrix[,1]
rankVectorAbMatrix<-as.matrix(rankVectorAbMatrix[,2:num_Abs])

ApproximationLists <-readxl::read_excel("~/Desktop/DeconvInput.xlsx", sheet = 2)

num_Tests <- dim(ApproximationLists)[2]
ApproximationLists<-column_to_rownames(ApproximationLists, "strain")
ApproximationLists <- ApproximationLists[strains$strain,]

df <- data.frame(matrix(ncol = num_Abs + 2, nrow = 0))
colnames(df) <- rbind(c("SampleID", colnames(rankVectorAbMatrix), "Pearson Corr", "p-value"))

for (num in seq(1, num_Tests-1, by=1)) {
  results <- pnnls(rankVectorAbMatrix, as.matrix(ApproximationLists[num]), sum = 1)
  proportions <- results$x 
  
  multipliedMatrix <- sweep(rankVectorAbMatrix,MARGIN=2,proportions,"*")
  finalList <- rowSums(multipliedMatrix)
  ApproximationList<- as.matrix(ApproximationLists[num])
  ApproximateReadyList <-ApproximationList
  
  cor_results <- cor.test(x=ApproximateReadyList, y=finalList,method = "pearson")
  pearson <- cor_results$estimate
  p.value <- cor_results$p.value
  
  resultList <- prepend(proportions, names(ApproximationLists[num]))
  resultList <- append(resultList, c(pearson[[1]], p.value))
  df[num, ] <- resultList
}
write.xlsx(df, "~/Desktop/DeconvResults.xlsx", row.names = FALSE)