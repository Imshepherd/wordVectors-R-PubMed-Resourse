#Download PubMed ABS file from NCBI per years .
#With MEDLINE Format and sort by Publication Date.

#Setpath
input.list = list.files("Word2vec data/PubMed/Raw data by years")
input.pathway = paste0("Word2vec data/PubMed/Raw data by years", "/", input.list)
output.pathway = "Word2vec data/PubMed/R file by years/"

#options(encoding = "UTF-8")

for (k in 1:length(input.list)){
  
  text.raw = readLines(input.pathway[k])
  start.pos = which(grepl("PMID- ", text.raw, fixed = TRUE))
  
  textlist = list()
  
  pb = txtProgressBar(min = 0, max = length(start.pos), style = 3)
  
  for (i in 1:(length(start.pos)-1)){
    
    textlist[[length(textlist)+1]] = text.raw[(start.pos[i]-1):(start.pos[i+1]-1)]
    # Encoding(textlist[[length(textlist)]]) = "UTF-8"
    
    setTxtProgressBar(pb, i)
  }
  
  close(pb);rm(text.raw)
  
  save(textlist, file = paste0(output.pathway, substr(input.list[k], 1, nchar(input.list[k])-4), ".RData"))
}
