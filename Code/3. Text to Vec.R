#library
library(wordVectors)

#Setpath
input.list = list.files("Word2vec data/PubMed/Cleaned text by years/")
input.pathway = "Word2vec data/PubMed/Cleaned text by years/"
output.pathway = "Word2vec data/PubMed/"

#Merge Text
Pubmed_all = NULL

pb = txtProgressBar(min = 0, max = length(input.list), style = 3)
  for (i in 1:length(input.list)){
    TRAIN.text = readLines(paste0(input.pathway, input.list[1]))
    TRAIN.text = paste0(TRAIN.text,"\n" )
    Pubmed_all = c(Pubmed_all, TRAIN.text)
    setTxtProgressBar(pb, i)
  }
close(pb)

#Write out
cat(Pubmed_all, file = paste0(output.pathway, "Pubmed_all.txt"), sep = "")

#Model training
PubMed = train_word2vec(paste0(output.pathway, "Pubmed_all.txt"), 
                        output = paste0(output.pathway, "Pubmed_vectors.bin"), 
                        threads = 10, vectors = 50, window=12)



