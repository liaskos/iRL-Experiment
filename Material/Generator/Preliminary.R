print_check_inventory <- function(language,type,lang,trailing = TRUE){
  for (t in lang[[language]][[type]]){
    cat(paste0("- ",t,"\n"))
  }
  if (trailing == TRUE){
    cat("- None of the above\n\n")
  } else {
    cat("\n\n")
  }
}

getConfig <- function(item){
  config %>% filter(name==item) %>% pull(value)
}


print_check_inventory <- function(caseNum,itemNum,langNum,type,image = FALSE,trailing = TRUE){
  conceptList = concepts_df %>% filter(langID == langNum, conceptType == type) %>% select(conceptID,conceptDescr)
  for (t in (1:nrow(conceptList))){
    if (image) {
      fileName = paste0(langNum,"-",caseNum,"-",itemNum,"-",conceptList[t,"conceptID"],".png")
      text = paste0("<img src='",getConfig("img_url"),fileName,"' style='height:100px' title='",conceptList[t,"conceptDescr"],"'>")
      cat(paste0("- ",text,"\n"))  
    } else {
      cat(paste0("- ",conceptList[t,"conceptDescr"],"\n"))  
    }
  }
  if (trailing == TRUE){
    cat("- None of the above\n\n")
  } else {
    cat("\n\n")
  }
  return (conceptList)
}


getYoutubeURL <- function(code){
  return(paste0("https://www.youtube.com/watch?v=",code))
}


#
# Case-related functions
#

getCaseHeader <- function(caseNum,summary){
  str = cases_df %>% filter(caseID==caseNum) %>% pull(caseHeader)
  return(eval(parse(text = str)))
}

getCaseText <- function(caseNum,summary){
  return(cases_df %>% filter(caseID==caseNum) %>% pull(caseText))
}

getCaseVideoCode <- function(caseNum,summary){
  return(cases_df %>% filter(caseID==caseNum) %>% pull(vCode))
}

getClassificationHeader <- function(caseNum,language){
  str = cases_df %>% filter(caseID==caseNum) %>% pull(classifHeader)
  return(eval(parse(text = str)))
}

getCaseItems_Entities <- function(caseNum,langNum){
  return(items_df %>% filter(caseID==caseNum, type == "entity") %>% select(itemID,order,
                                                                    item_text,
                                                                    paste0(langNum,"_auth")))
}
getCaseItems_Relationships <- function(caseNum,langNum){
  return(items_df %>% filter(caseID==caseNum, type == "relationship") %>% select(itemID,order,
                                                                           item_text,
                                                                           paste0(langNum,"_auth")))
}

getItemAuthClassification <- function(caseNum,itemNum,langNum) {
  return(items_df %>% filter(caseID == caseNum,itemID == itemNum) %>% pull(paste0(langNum,"_auth")))
}

#
# Language- and Concept-related functions
#


getLanguageVideoCode <- function(langNum){
  return(lang_df %>% filter(langID==langNum) %>% pull(vCode))
}

getLangName <- function(langID){
  lang_names = setNames(unique(lang_df[c("langID", "langDescr")])$langDescr, 
                        unique(lang_df[c("langID", "langDescr")])$langID)
  return(lang_names[[langID]])
}

getLangCodeList <- function(){
  return (unique(lang_df$langID))
}

getLangCheatSheetURL_Entities <- function(langNum) {
  return(lang_df %>% filter(langID==langNum) %>% pull(urlEntities))
}

getLangCheatSheetURL_Relationships <- function(langNum) {
  return(lang_df %>% filter(langID==langNum) %>% pull(urlRelationships))
}




#
# Loading Language and Concepts
#


concepts_df <- read_excel("../Config/config.xlsx", sheet = "Concepts")
lang_df <- read_excel("../Config/config.xlsx", sheet = "Languages")
config <- read_excel("../Config/config.xlsx", sheet = "Config")
cases_df <- read_excel("../Config/config.xlsx", sheet = "Cases")
items_df <- read_excel("../Config/config.xlsx", sheet = "Items")



#
# Construct Language lists and structures
#


entity_names = NULL
relationship_names = NULL
summary = NULL

for (l in getLangCodeList()) {

    entity_names[[l]] = concepts_df %>% filter(langID == l,conceptType == "entity") %>% pull(conceptDescr)
  
    relationship_names[[l]] = concepts_df %>% filter(langID == l,conceptType == "relationship") %>% pull(conceptDescr)
  
    summary[[l]] = paste0("(",paste0(entity_names[[l]][c(1,2)], collapse=", "),", ",relationship_names[[l]][c(1)],", etc.)")

}


#
# NOT SURE WHAT THESE ARE
#


# concept_elements_desc_1 = items %>% filter(type == "concept",description ==1) %>% arrange(order)
# concept_elements_1 = concept_elements_desc_1 %>% pull(item_text)
# concept_elements_auth_1 = list(gmo = concept_elements_desc_1 %>% pull(gmo_auth_descr),
#                                gme = concept_elements_desc_1 %>% pull(gme_auth_descr))
# 
# relationship_elements_desc_1 = items %>% filter(type == "relationship",description ==1) %>% arrange(order)
# relationship_elements_1 = relationship_elements_desc_1 %>% pull(item_text)
# relationship_elements_auth_1 = list(gmo = relationship_elements_desc_1 %>% pull(gmo_auth_descr),
#                                     gme = relationship_elements_desc_1 %>% pull(gme_auth_descr))
# 
# 
# concept_elements_desc_2 = items %>% filter(type == "concept",description == 2) %>% arrange(order)
# concept_elements_2 = concept_elements_desc_2 %>% pull(item_text)
# concept_elements_auth_2 = list(gmo = concept_elements_desc_2 %>% pull(gmo_auth_descr),
#                                gme = concept_elements_desc_2 %>% pull(gme_auth_descr))
# 
# relationship_elements_desc_2 = items %>% filter(type == "relationship",description ==2) %>% arrange(order)
# relationship_elements_2 = relationship_elements_desc_2 %>% pull(item_text)
# relationship_elements_auth_2 = list(gmo = relationship_elements_desc_2 %>% pull(gmo_auth_descr),
#                                     gme = relationship_elements_desc_2 %>% pull(gme_auth_descr))
# 
# 
# 
# concept_elements = list(concept_elements_1,concept_elements_2)
# relationship_elements = list(relationship_elements_1,relationship_elements_2)
# 
# concept_elements_auth = list(concept_elements_auth_1,concept_elements_auth_2)
# relationship_elements_auth = list(relationship_elements_auth_1,relationship_elements_auth_2)
