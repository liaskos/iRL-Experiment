source("Generator.R")
# MAIN: Export Modeling Language ---------------------
outDir = "../Output/"
dataPath = "../Config/"
generateFiles = TRUE


#
# Loading Language and Concepts
#
configID = "config"
configFile = paste0(dataPath, configID,".xlsx")

concepts_df <- read_excel(configFile, sheet = "Concepts")
lang_df <- read_excel(configFile, sheet = "Languages")
config <- read_excel(configFile, sheet = "Config")
cases_df <- read_excel(configFile, sheet = "Cases")
items_df <- read_excel(configFile, sheet = "Items")

targetDir = paste0(configID," - ",format(Sys.time(), format = "%y-%m-%d %H-%M-%S"))
dir.create(file.path(outDir, targetDir), showWarnings = TRUE)
outPath = paste0(outDir,targetDir,"/")
file.copy(configFile,outPath)


key_obs_ = tribble(~psy_item, ~item, ~item_full, 
                   ~description, ~language,~type,
                   ~psy_option, ~auth)
key_att_ = tribble(~psy_item, ~language, ~concept)

for (langID in c("iRL")){
  outFile = paste0(outPath,langID,"-checked.txt")
  if (generateFiles) {
    sink(outFile, append=FALSE)
  }
  prolific(1)
  print_preliminary(langID,
                    sample(1:5, size = 3, replace = FALSE),
                    sample(1:5, size = 3, replace = FALSE),
                    sample(1:5, size = 3, replace = FALSE),
                    sample(1:5, size = 3, replace = FALSE)
                    )
  key_att_ = print_overlap(langID, key_att_)
  for (caseID in c("therm")){
    key_obs_ = print_observational_check(langID,caseID,key = key_obs_)
  }
  key_att_ = print_self_reporting(langID, key_att_)
  demographics(FALSE)
  pilot(TRUE)
  prolific(2)
  if (generateFiles) {
    sink()
  }
}

if (generateFiles){
  write.csv(x = key_obs_, file=paste0(outPath,"key.csv"),row.names = FALSE)
  write.csv(x = key_att_, file=paste0(outPath,"key-attitudinal.csv"),row.names = FALSE)
}
