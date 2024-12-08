# Libraries --------------------------------------------
source("Library.R")
source("Preliminary.R")

# Preliminary --------------------------------------------

print_preliminary <- function(language) {
  
  cat("scale: ",paste0(language,"-concepts\n"))
  print_check_inventory(language,"concepts",lang)
  
  cat("scale: ",paste0(language,"-relationships\n"))
  print_check_inventory(language,"relationships",lang)

  cat("scale: ",paste0(language,"-concepts-test\n"))
  print_check_inventory(language,"concepts",lang,FALSE)
  
  cat("scale: ",paste0(language,"-relationships-test\n"))
  print_check_inventory(language,"relationships",lang,FALSE)

  cat("l: intro_descr\n")
  cat("t: youtube\n")
  cat("q: <h2>Overview</h2> Thank you again for agreeing to participate. Please watch the following short video with an overview of this experiment. If embedded video does not load, you can  <a href='",introvid_url,"' target=\"_blank\">watch it directly on Youtube</a> \n")
  cat(paste0("- ",introvid_code,"\n\n"))
  
  cat("l: vid1\n")
  cat("t: youtube\n")
  cat(paste0("q: <h2>",lang_names[language],"</h2>To start please watch the following video presentation about <b>",lang_names[language],"</b>. If embedded video does not load, you can  <a href='",video[language],"' target=\"_blank\">watch it directly on Youtube</a> \n"))
  cat(paste0("- ",video_code[language],"\n\n"))
  
  cat("page: begin\n\n")
  cat("l: conceptUnderstandingInfo\n")
  cat("t: info\n")
  cat(paste0('q: <h2>Comprehension Questions</h2> Based on what you learned in the video, answer the following questions. You can always <a href=\"',video[language],'" target=\"_blank\">watch the video again</a> (opens in new window) or refer to <a href=\"',url_concepts[language],'\" target=\"popup\" onclick=\"window.open(\'', url_concepts[language],'\',\'popup\',\'width=600,height=400\');return false;"> this short "cheat-sheet"</a>  (pops-up a window).\n\n'))
  
  
  
  correct_code_cd = list(gmo = c(3,2,1),
                         gme = c(2,1,3))
  cat("l: conceptUnderstandingDefn\n")  
  cat("t: scale ",paste0(language,"-concepts-test\n"))
  cat("o: random\n")
  cat("q: Please match each of the following definitions with the concept it defines.\n")
  for (t in (names %>% filter (Type == "concept", Language == language) %>% pull(Definition))[correct_code_cd[[language]]]){
    cat("- ", t," \n")
  }
  cat("\n")
  
  correct_code_ce = list(gmo = c(1,3,2),
                         gme = c(1,2,3))
  cat("l: conceptUnderstandingExample\n")  
  cat("t: scale ",paste0(language,"-concepts-test\n"))
  cat("o: random\n")
  cat("q: Please match each of the following examples with the concept it exemplifies.\n")
  for (t in (names %>% filter (Type == "concept", Language == language) %>% pull(Example))[correct_code_ce[[language]]]){
    cat("- ", t," \n")
  }
  cat("\n")
  
  correct_code_rd = list(gmo = c(2,1,4,3),
                         gme = c(4,3,1,2))
  cat("l: relationshipUnderstandingDefn\n")  
  cat("t: scale ",paste0(language,"-relationships-test\n"))
  cat("o: random\n")
  cat("q: Please match each of the following definitions with the relationship it defines.\n")
  for (t in (names %>% filter (Type == "relationship", Language == language) %>% pull(Definition))[correct_code_rd[[language]]]){
    cat("- ", t," \n")
  }
  cat("\n")
  
  
  correct_code_re = list(gmo = c(2,4,1,3),
                         gme = c(1,4,3,2))
  cat("l: relationshipUnderstandingExample\n")  
  cat("t: scale ",paste0(language,"-relationships-test\n"))
  cat("o: random\n")
  cat("q: Please match each of the following examples with the relationship it exemplifies.\n")
  for (t in (names %>% filter (Type == "relationship", Language == language) %>% pull(Example))[correct_code_re[[language]]]){
    cat("- ", t," \n")
  }
  cat("\n")
  
  cat("page: end\n\n")
  
}

print_observational_check <- function(langID, caseID, key){
  
  cat("\n\n# # # # # # # # # # # # # # # # #\n")
  cat("#   O B S E R V A T I O N A L   # \n")
  cat("# # # # # # # # # # # # # # # # #\n\n")
  
  
  
  cat("page: begin\n\n")
  
  cat(paste0("l: directions_",caseID,"\n"))
  cat("t: youtube\n")
  cat(paste0("q: ", getClassificationHeader(caseID)," \n"))
  cat(paste0("- ",getCaseVideoCode(caseID),"\n\n"))
  
  cat(paste0("l: description_",caseID,"\n"))
  cat("t: info\n")
  cat("q: ",getCaseText(caseID),"\n\n")

  
  cat(paste0("l: concepts_",caseID,"\n"))
  cat("t: info\n")
  cat(paste0('q: <h4>Concepts</h4> Based on what you learned in the video and the information in the above passage, classify each of the following expressions to <b>one or more concepts</b> that best describe it. You can always <a href=\"',getYoutubeURL(getLanguageVideoCode(langID)),'" target=\"_blank\">watch the vocabulary presentation video again</a> (opens in new window) or refer to <a href=\"',getLangCheatSheetURL_Entities(langID),'\" target=\"popup\" onclick=\"window.open(\'', getLangCheatSheetURL_Entities(langID),'\',\'popup\',\'width=600,height=400\');return false;"> this short "cheat-sheet"</a>  (pops-up a window). Please check <b>None of the above</b> if you think that none of the listed concepts describes the expression well. \n\n'))
  
  #cat("random: begin\n\n")
  
  
  for (i in (1:nrow(getCaseItems_Entities(caseID,langID)))) {
    cat(paste0("l: ",langID,"_",caseID,"_",i,"\n"))
    cat(paste0("t: check\n"))
    cat(paste0("o: require 1\n"))
    cat(paste0('q: <i>"',getCaseItems_Entities(caseID,langID)[i,"item_text"], '"</i>\n'))
    #print_check_inventory(language,"concepts",lang)
    cList = print_check_inventory(caseID,i,langID,"entity",image = TRUE,trailing = TRUE)
    cat("")

    cset = c(cList %>% pull(conceptID),"None")
    for (j in 1:(length(cset))) {
      key = key %>% add_row(psy_item = paste0(langID,"_",caseID,"_",i,":",j),
                            item = paste0(caseID,"_item",i,"_concepts"), 
                            item_full = getCaseItems_Entities(caseID,langID)[[i,"item_text"]],
                            description = caseID, 
                            language = langID, 
                            type = "concept",
                            psy_option = cset[j],
                            auth = getItemAuthClassification(caseID,i,langID))
    }
  }

  #cat("random: end\n\n")
  
  
  
  cat(paste0("l: relationships_",caseID,"\n"))
  cat("t: info\n")
  cat(paste0('q: <h4>Relationships</h4> Based on what you learned in the video and the information in the above passage, classify each of the following expressions to <b>one or more relationships</b> that best describe it. You can always <a href=\"',getYoutubeURL(getLanguageVideoCode(langID)),'" target=\"_blank\">watch the vocabulary presentation video again</a> (opens in new window) or refer to <a href=\"',getLangCheatSheetURL_Relationships(langID),'\" target=\"popup\" onclick=\"window.open(\'', getLangCheatSheetURL_Relationships(langID),'\',\'popup\',\'width=600,height=400\');return false;"> this short "cheat-sheet"</a>  (pops-up a window). Please check <b>None of the above</b> if you think that none of the listed relationships describes the expression well.\n\n'))
  
  #cat("random: begin\n\n")
  
  
  
  for (i in (1:nrow(getCaseItems_Relationships(caseID,langID)))) {
    cat(paste0("l: ",langID,"_",caseID,"_",i,"\n"))
    cat(paste0("t: check\n"))
    cat(paste0("o: require 1\n"))
    cat(paste0('q: <i>"',getCaseItems_Relationships(caseID,langID)[i,"item_text"], '"</i>\n'))
    #print_check_inventory(language,"concepts",lang)
    cList = print_check_inventory(caseID,i,langID,"relationship",image = TRUE,trailing = TRUE)
    cat("")
    
    cset = c(cList %>% pull(conceptID),"None")
    for (j in 1:(length(cset))) {
      key = key %>% add_row(psy_item = paste0(langID,"_",caseID,"_",i,":",j),
                            item = paste0(caseID,"_item",i,"_relationships"), 
                            item_full = getCaseItems_Relationships(caseID,langID)[[i,"item_text"]],
                            description = caseID, 
                            language = langID, 
                            type = "relationship",
                            psy_option = cset[j],
                            auth = getItemAuthClassification(caseID,i,langID))
    }
  }
  
  
  #cat("random: end\n\n")
  cat("page: end\n\n")
  
  return(key)
}



print_overlap <- function(language, key_att){

  # Overlap ---------
  
  cat("page: begin\n\n")
  
  example = paste0(
    "(", paste(lang[[language]][["concepts"]][c(1,2)],collapse =","),"), ",
    "(", paste(lang[[language]][["concepts"]][c(2,3)],collapse =","),"), ",
    "(", paste(lang[[language]][["relationships"]][c(1,2)],collapse =","),")"
  )
  
  cat("l: overlap_dir\n")
  cat("t: youtube\n")
  cat(paste0("q: <h2>Overlap</h2>Please watch the following video with directions about this page. If embedded video does not load, you can  <a href='",dirvideo["overlap"],"' target=\"_blank\">watch it directly on Youtube</a>\n"))
  cat(paste0("- ",dirvideo_code["overlap"],"\n\n"))
    
  cat("l: conceptOverlap\n")
  cat("t: range\n")
  cat('q: <h3>Overlap Assessment</h3> Consider <b>pairs</b> of the modeling concepts and relationships discussed earlier: <b>',example,'</b> etc. For each pair, rate how much you think the two concepts in the pair <b>overlap</b>, i.e., refer to the same thing. Choose any level from 0 to 10, between <b>No Overlap</b> (0, they concepts in the pair are completely distinct) and <b>Complete Overlap</b> (10, the concepts in the pair refer to the same thing in different words).')
  cat('You can review the language again by referring to <a href=\"',video[language],'\" target=\"_blank\">the previous video</a> (opens in new window) or to <a href=\"',url_concepts[language],'\" target=\"popup\" onclick=\"window.open(\'',url_concepts[language],"','popup','width=600,height=400');return false;\"> the cheat-sheet</a> (pops-up a window).\n")
  
  k = 1
  for (i in 1:(length(lang[[language]][["concepts"]])-1)) {
    for (j in (i+1):length(lang[[language]][["concepts"]])){
      cat("- {min=0,max=10,left=No Overlap,right=Complete Overlap,start=0} <u><b>",lang[[language]][["concepts"]][i],"</b></u> and <u><b>",lang[[language]][["concepts"]][j],"</b></u>\n")
      key_att = key_att %>% add_row(psy_item = paste0("conceptOverlap:",k),
                                    language = language,
                                    concept = paste0(lang[[language]][["concepts"]][i],"-",lang[[language]][["concepts"]][j]))
      k = k + 1
    }
  }
  
  for (i in 1:(length(lang[[language]][["relationships"]])-1)) {
    for (j in (i+1):length(lang[[language]][["relationships"]])){
      cat("- {min=0,max=10,left=No Overlap,right=Complete Overlap,start=0} <u><b>",lang[[language]][["relationships"]][i],"</b></u> and <u><b>",lang[[language]][["relationships"]][j],"</b></u>\n")
      key_att = key_att %>% add_row(psy_item = paste0("conceptOverlap:",k),
                                    language = language,
                                    concept = paste0(lang[[language]][["relationships"]][i],"-",lang[[language]][["relationships"]][j]))
      k = k + 1
    }
  }
  
  cat("\n page: end\n\n")
  
  return(key_att)
}

print_self_reporting <- function(language, key_att){
  cat("page: begin\n\n")

# Relevance ---------
  
  cat("l: relevanceDescr\n")
  cat("t: youtube\n")
  cat("q: <h2>Relevance</h2>Please watch the following video with directions about this page.If embedded video does not load, you can  <a href='",dirvideo["relevance"],"' target=\"_blank\">watch it directly on Youtube</a>\n")
  cat(paste0("- ",dirvideo_code["relevance"], "\n\n"))
  
  
  cat("l: conceptRelevance\n")
  cat("t: range\n")
  cat('q: <h3>Concept Relevance</h3> Consider the modeling <b>concepts</b> discussed earlier (<b>',paste0(lang[[language]][["concepts"]],collapse = ", "),'</b>). Consider also the two cases you studied (Heather\'s store and Kim\'s travels). Rate how <b>relevant</b> you find each concept to what is presented in the two cases. You may review again the cases <a href=\"',cases,'\" target=\"_blank\">here</a> (opens in new window). You may review the vocabulary again by referring to <a href=\"',video[language],'\" target=\"_blank\">the vocabulary presentation video</a> (opens in new window) or to <a href=\"',url_concepts[language],'\" target=\"popup\" onclick=\"window.open(\'',url_concepts[language],"','popup','width=600,height=400');return false;\"> the cheat-sheet</a> (pops-up a window).\n")
  for(i in 1:length(lang[[language]][["concepts"]])) {
    cat("- {min=0,max=10,left=Not at all relevant,right=Very relevant,start=5} Relevance of concept <u><b>",lang[[language]][["concepts"]][i],"</b></u> in the cases\n")
    key_att = key_att %>% add_row(psy_item = paste0("conceptRelevance:",i), 
                                  language = language,
                                  concept = lang[[language]][["concepts"]][i])
  }
  cat("\n")
  
  
  cat("l: relationshipRelevance\n")
  cat("t: range\n")
  cat('q: <h3>Relationship Relevance</h3>Consider now the modeling <b>relationships</b> discussed earlier (<b>',paste0(lang[[language]][["relationships"]],collapse = ", "),'</b>). Consider also the two cases you studied (Heather\'s store and Kim\'s travels). Rate how <b>relevant</b> you find each of the relationships to what is presented in the two cases. You may review again the cases <a href=\"',cases,'\" target=\"_blank\">here</a> (opens in new window). You may review the vocabulary again by referring to <a href=\"',video[language],'\" target=\"_blank\">the vocabulary presentation video</a> (opens in new window) or to <a href=\"',url_concepts[language],'\" target=\"popup\" onclick=\"window.open(\'',url_relationships[language],"','popup','width=600,height=400');return false;\"> the cheat-sheet</a> (pops-up a window).\n")
  for(i in 1:length(lang[[language]][["relationships"]])) {
    cat("- {min=0,max=10,left=Not at all relevant,right=Very relevant,start=5} Relevance of relationship <u><b>",lang[[language]][["relationships"]][i],"</b></u>\n")
    key_att = key_att %>% add_row(psy_item = paste0("relationshipRelevance:",i),
                                  language = language,
                                  concept = lang[[language]][["relationships"]][i])
  }
  cat("\n")
  
  cat("page: end\n\n")
  
  # Completeness ---------
  cat("page: begin\n\n")
  
  cat("l: completenessDescr\n")
  cat("t: youtube\n")
  cat("q: <h2>Completeness</h2>Please watch the following video with directions about this page.If embedded video does not load, you can  <a href='",dirvideo["completeness"],"' target=\"_blank\">watch it directly on Youtube</a>\n")
  cat(paste0("- ",dirvideo_code["completeness"], "\n\n"))
  
  cat("l: conceptCompleteness\n")
  cat("t: range\n")
  cat('q: <h3>Concept Completeness</h3>Consider again the two cases you studied (Heather\'s store and Kim\'s travels) and the items in the cases that you were asked to classify. Consider also the modeling <b>concepts</b> that you used. Do you agree with the following statement: <BR>\n')
  cat('<p style="text-align:center"><i>The set of concepts included in the vocabulary (<b>',paste(lang[[language]][["concepts"]],collapse = ", "),'</b>) were <b>sufficient</b> for characterizing relevant parts of the described cases. <b>No more concepts need to be added</b> to the set to make it more complete.</i></p>\n')
  cat("- {min=-7,max=+7,left=Strongly Disagree,right=Strongly Agree,start=0}\n")
  cat("\n")
  key_att = key_att %>% add_row(psy_item = "conceptCompleteness:1", 
                                language = language,
                                concept = language)
  
  
  cat("l: relationshipCompleteness\n")
  cat("t: range\n")
  cat('q: <h3>Relationship Completeness</h3>Consider again the two cases you studied (Heather\'s store and Kim\'s travels) and the items in the cases that you were asked to classify. Consider also the modeling <b>relationships</b> that you used. Do you agree with the following statement: <BR>\n')
  cat('<p style="text-align:center"><i>The set of relationships included in the vocabulary (<b>',paste(lang[[language]][["relationships"]],collapse = ", "),'</b>) were <b>sufficient</b> for characterizing relevant parts in the described cases.  <b>No more relationships need to be added</b> to the set to make it more complete.</i>\n')
  cat("- {min=-7,max=+7,left=Strongly Disagree,right=Strongly Agree,start=0}\n")
  cat("\n")
  key_att = key_att %>% add_row(psy_item = "relationshipCompleteness:1", 
                                language = language,
                                concept = language)
  
  
  cat("page: end\n\n")

  
  return(key_att)
}

demographics <- function(final) {
  
  cat("\n\n# # # # # # #\n")
  cat("# D E M O S #\n")
  cat("# # # # # # # \n\n")
  
  
  cat("page: begin\n\n")
  
  cat("l: closing\n")
  cat("t: info\n")
  if (final) {
    cat("q: <h2>Demographics</h2> Almost done! We only have a last few demographic type of questions.\n\n")
  } else {
    cat("q: <h2>Demographics</h2> Please tell us a few things about yourself.\n\n")
  }
  
  cat("l: Age\n")
  cat("t: textline\n")
  cat("q: <h3>Age</h3> What is your age?\n")
  cat("- {min=0,max=120} Type your age (must be numerical)\n\n")
  
  cat("l: Sex\n")
  cat("t: radio\n")
  cat("q: <h3>Sex</h3> Are you:\n")
  cat("- Female.\n")
  cat("- Male.\n")
  cat("- Other.\n")
  cat("- Rather not say.\n\n")
  
  
  cat("l: Fl\n")
  cat("t: check\n")
  cat("o: require 1 2\n")
  cat("q: <h3>Field</h3> Which of the following best describes your field in terms of formal education? Select the one (1) or at most two (2) most relevant.\n")
  cat("- Science, Technology and Engineering.\n")
  cat("- Business and Economics.\n")
  cat("- Health Sciences.\n")
  cat("- Social Sciences and Humanities (e.g. Sociology, English, History etc.).\n")
  cat("- Fine Arts.\n")
  cat("- Education.\n")
  cat("- Other/None.\n\n")
  
  
  cat("l: englishFirst\n")
  cat("t: radio\n")
  cat("q: <h3>Language Ability (1/2)</h3> Are you a native speaker of <b>English</b>:\n")
  cat("- Yes\n")
  cat("- No\n")
  cat("- Partially\n\n")
  
  cat("scale: english_scale\n")
  cat("- Fair\n")
  cat("- Good\n")
  cat("- Very Good\n")
  cat("- Excellent\n\n")
  
  cat("l: english\n")
  cat("t: scale english_scale\n")
  cat("q: <h3>Language Ability (2/2)</h3> Please rate your ability in <b>English</b> with respect to the following activities:\n")
  cat("- Reading\n")
  cat("- Writing\n")
  cat("- Listening\n")
  cat("- Speaking\n\n")
  
  cat("page: end\n\n")
  
}  

mturk <- function(count){
  cat("# # # # # # # # #\n")
  cat("# M - T U R K   # \n")
  cat("# # # # # # # # #\n\n")
  cat(paste0("l: mturkID",count,"\n"))
  cat("t: textline\n")
  if (count == 1) {
    cat("q: <h2>MTurk ID</h2>Thank you for agreeing to participate! What is your Mechanical Turk participant ID?\n")
  } else {
  cat("q: <h2>Done!</h2>Thank you for participating! Just in case, can you please enter your Mechanical Turk participant ID again?\n")
  }
  cat("- {require} Participant ID:\n\n") 
}

prolific <- function(count){
  cat("# # # # # # # # # # # #\n")
  cat("#   P R O L I F I C   # \n")
  cat("# # # # # # # # # # # #\n\n")
  cat(paste0("l: mturkID",count,"\n"))
  cat("t: textline\n")
  if (count == 1) {
    cat("q: <h2>Participant ID</h2>Thank you for agreeing to participate! What is your Prolific participant ID?\n")
  } else {
    cat("q: <h2>Done!</h2>Thank you for participating! Just in case, can you please enter your Prolific participant ID again?\n")
  }
  cat("- {require} Participant ID:\n\n") 
}

pilot <- function(final) {
  
  cat("\n\n# # # # # # #\n")
  cat("# P I L O T #\n")
  cat("# # # # # # # \n\n")
  
  cat("page: begin\n\n")
  
  cat("l: feedback\n")
  cat("t: info\n")
  if(final) {
    cat("q: <h2>Feedback</h2> Almost done! In order to help us make this instrument better, can you provide us with your opinion about it?\n\n")
  } else {
    cat("q: <h2>Feedback</h2> In order to help us make this instrument better, can you provide us with your opinion about it?\n\n")
  }
  
  cat("l: system\n")
  cat("t: radio\n")
  cat("q: <h3>Device Type</h3> What type of device are you using to complete this study? \n")
  cat("- A mobile phone\n")
  cat("- A tablet \n")
  cat("- A desktop or laptop computer\n")
  cat("- Other\n\n")
  
    
  cat("l: instrumentClarity\n")
  cat("t: radio\n")
  cat("q: <h3>Clarity</h3> How clear (easy to understand) was the material and questions you were presented?\n")
  cat("- Very clear\n")
  cat("- Unclear at places\n")
  cat("- Very unclear\n\n")
  

  cat("l: instrumentTime\n")
  cat("t: radio\n")
  cat("q: <h3>Time</h3> Does the time initially indicated reflects how long it took you to complete the tasks? \n")
  cat("- Yes, the time was actually more than enough.\n")
  cat("- Yes, the time is just about right. \n")
  cat("- No, it took me more time than I was expecting. \n\n")
  
  cat("l: instrumentIssues\n")
  cat("t: textbox\n")
  cat("q: <h3>Feedback</h3> Are there any parts of the tasks you performed that needs improvement in terms of, e.g., clarity, ease of reading and understanding, time?\n")
  cat("- {w=50,h=3} Comments:\n\n")
  
  cat("page: end\n\n")
  
}



