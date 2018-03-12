#library
library(magrittr)

#Setpath
input.list = list.files("Word2vec data/PubMed/R file by years/")
input.pathway = paste0("Word2vec data/PubMed/R file by years/", input.list)
output.pathway = "Word2vec data/PubMed/Cleaned text by years/"

#Function: get abstract text
Get.ABS = function(TEXT){
    ABS.T =  grepl("AB  - ", TEXT, fixed = T)
  empty.T =  grepl("      ", TEXT, fixed = T)
  
  ABS.pos = which(ABS.T|empty.T)
  ABS.pos = ABS.pos[!ABS.pos<which(ABS.T)]
  
  if ( sum(ABS.T) > 0) {
    if ( sum(length(ABS.pos)) == 1 ){
      ABS = TEXT[ABS.T]
    } else {
  
      ABS = TEXT[ABS.T]
      
      for (j in 2:length(ABS.pos)){
        if (diff(ABS.pos)[j-1] != 1 ) break
        ABS = c(ABS, TEXT[ABS.pos[j]])
      }
    }
  } else {
    ABS = NULL
  }
  
  ABS = gsub("AB  - ", "", ABS, fixed = T) %>% paste(., collapse = " ") %>% gsub("[ ]+", " ", .)
  return(ABS)
}

Get.TI = function(TEXT){
  title.T =  grepl("TI  - ", TEXT, fixed = T)
  empty.T =  grepl("      ", TEXT, fixed = T)
  
  title.pos = which(title.T|empty.T)
  title.pos = title.pos[!title.pos < which(title.T)]
  
  if ( sum(title.T) > 0) {
    if (  sum(length(title.pos)) == 1 ){
      title = TEXT[title.T]
    } else {
     
      title = TEXT[title.T]
      
      for (j in 2:length(title.pos)){
        if (diff(title.pos)[j-1] != 1 ) break
        title = c(title, TEXT[title.pos[j]])
      }
    }
  }  else {
    title = NULL
  }
  
  title = gsub("TI  - ", "", title, fixed = T) %>% paste(., collapse = " ") %>% gsub("[ ]+", " ", .)
  return(title)
}

#Function: cleaned text
Remove.Subtitle = function(str, stopwords) {
   SPLIT = unlist(strsplit(str, " "))
   paste(SPLIT[!SPLIT %in% stopwords], collapse = " ")
}

Subtitle = c("OBJECTIVE:", "DESIGN:", "METHODS:", "RESULTS:", "BACKGROUND AND OBJECTIVES:", "METHOD:", "MATERIALS AND METHODS:", 
             "BACKGROUND:", "CONCLUSION:", "CONCLUSIONS:", "PURPOSE:", "AIM:", "SETTING:", "OBJECTIVES:", "AIMS:",
             "INTRODUCTION:", "SUBJECTS:", "SUMMARY:", "DISCUSSION:", "MEASUREMENTS:", "MEASURES:",
             "MATERIAL:", "TREATMENT:", "MATERIALS:", "OUTCOME MEASURES:", " PARTICIPANTS:", "SAMPLE:", "RESULT:", "UNLABELLED:",
             "CASE REPORT:", "STUDY:", "PROTOCOL:", "HYPOTHESIS:", "FINDINGS:", "OBJECT:", "DEVELOPMENT:", "CONTEXT:", "MAIN OUTCOME MEASUREMENT:",
             "AIMS/HYPOTHESIS:", "CONCLUSION/INTERPRETATION:", "BACKGROUND/AIMS:", "INTERVENTIONS:", "DATA SOURCE:", "INVESTIGATION:", "INTERPRETATION:",
             "PURPOSE/OBJECTIVE:")


Remove.quotation = function(TEXT){
  POS.q1 = gregexpr("[(]", TEXT)[[1]]
  POS.q2 = gregexpr("[)]", TEXT)[[1]]
  text.q = NULL
  for (k in 1:(length(POS.q1)+1)){
    if (k == 1){
      text.q[length(text.q)+1] = substr(TEXT, 1, POS.q1[k])
    } else if ( k == length(POS.q1)+1){
      text.q[length(text.q)+1] = substr(TEXT, POS.q2[k-1], nchar(TEXT))
    } else {
      text.q[length(text.q)+1] = substr(TEXT, POS.q2[k-1], POS.q1[k])
    }
  }
  
  paste0(text.q, collapse = "")
}

#
for (j in 1:length(input.pathway)){
  
  load(input.pathway[j])
  CleanedText.list = list()
  
  pb = txtProgressBar(min = 1, max = length(textlist), style = 3)
  
  for (i in 1:length(textlist)){
    
    TEXT = textlist[[i]]
    Encoding(TEXT) = "UTF-8"
    
    TEXT = paste(Get.TI(TEXT), Get.ABS(TEXT), sep = " ") %>% gsub("[ ]+", " ", .)

    TEXT = Remove.Subtitle(TEXT, Subtitle)
    TEXT = Remove.quotation(TEXT)
    TEXT = tolower(TEXT)
    TEXT = gsub("[^a-z0-9.]", " ", TEXT) %>% gsub("[ ]+", " ", .) 
    
    TEXT = unlist(strsplit(TEXT, " "))
    TEXT = TEXT[TEXT != ""]
    TEXT[TEXT == "."] = "<dot>"
    TEXT[!grepl("[a-z]", TEXT)] = "0"
    TEXT[TEXT == "<dot>"] = "."
    
    TEXT = paste0(TEXT, collapse = " ")
    TEXT = gsub("[^a-z0-9]", " ", TEXT) %>% gsub("[ ]+", " ", .) 
 
   #for Write out text
    TEXT = paste0(TEXT,"\n" )
  
    CleanedText.list[[length(CleanedText.list)+1]] = TEXT
    
    setTxtProgressBar(pb, i)
  }
  
  close(pb)
  
  #for Write out text
  cat(unlist(CleanedText.list), file = paste0(output.pathway, "Pubmed_", 1999+j, ".txt"), sep = "")
}




