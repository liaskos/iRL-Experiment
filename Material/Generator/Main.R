source("Generator.R")
# MAIN: Export Modeling Language ---------------------
outpath = "../Output/"
dataPath = "../Config/"
generateFiles = TRUE

key_obs_ = tribble(~psy_item, ~item, ~item_full, 
                   ~description, ~language,~type,
                   ~psy_option, ~auth)
key_att_ = tribble(~psy_item, ~language, ~concept)

for (langID in c("iRL")){
  outfile = paste0(outpath,langID,"-checked.txt")
  if (generateFiles) sink(outfile, append=FALSE)
  prolific(1)
  #print_preliminary(language)
  #key_att_ = print_overlap(language, key_att_)
  for (caseID in c("therm")){
    key_obs_ = print_observational_check(langID,caseID,key = key_obs_)
  }
  #key_att_ = print_self_reporting(language, key_att_)
  demographics(FALSE)
  pilot(TRUE)
  prolific(2)
  if (generateFiles) sink()
}

if (generateFiles){
  write.csv(x = key_obs_, file=paste0(dataPath,"key.csv"),row.names = FALSE)
#write.csv(x = key_att_, file=paste0(dataPath,"key-att.csv"),row.names = FALSE)
}