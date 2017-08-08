# server.R
library(shiny)
library(shinyTree)


library(jsonlite)
# recreate your data.frame


#convert the list to a JSON, using the package of your choice



#take list of elements and parents/children
#convert list to a tree
#using the tree, create a json.

# recurJSON <- function(tree, i){
#   if(tree$isLeaf){
#     if(i == 0){
#         x <- sprintf('{"id" :"%s", "text":"%s"},', tree$name, tree$name)
#         
#         return(x)
#     }else{
#       x <- sprintf('{"id" :"%s", "text":"%s"},', tree$name, tree$name)
#       print(x)
#       return(x)
#     }
#   }else{
#     x <-sprintf('{"id" :"%s", "text":"%s"},', tree$name, tree$name)
#     return(x)
#   }
# }
# x <- recurJSON(tree, 0)


# #read in a map
# map <- read.csv('event_tree.csv')
# #after read in, we want to convert it to a tree, and clean it so that it can be made into a tree.
# library('data.tree')
# tree <- FromDataFrameNetwork(as.data.frame(map)) 
# listoflists <- (ToListExplicit(tree, unname = TRUE, rootName = "text", nameName = "text", childrenName = "children"))
# library(jsonlite)
# jsonfile <- toJSON(listoflists)







jsonTree<- function(idTree){
	switch(idTree,
    "A" = '[{"id":"node_2",
    "text":"Root node with options",
    "state":{"opened":false,"selected":false},
    "children":[{"text":"Child 1"},"Child 2"]}]',
    
    "A_closed" = '[{"id":"node_2",
    "text":"Root node with options",
    "state":{"opened":false,"selected":false},
    "children":[{"text":"Child 1"},"Child 2"]}]',
    
		"B" = '[{"id":"ajson1","parent":"#","text":"Simplerootnode","li_attr":{"class":"project","stid":"project-1"}},{"id":"ajson2","parent":"#","text":"Rootnode2"},{"id":"ajson3","parent":"ajson2","text":"Child1"},{"id":"ajson4","parent":"ajson2","text":"Child2"}]',
		"List" = '[{"id" : "earth", "text":"earth"}]',
		"Z" = x)
}

shinyServer(function(input, output, session) {
	output$idSelected <- renderPrint({
		tree <- input$tree
		if (is.null(tree)){
			"None"
		} else{
			str(get_selected(input$tree, format = "classid"))
		}
	})
	
	# Tree is initialized without nodes
	output$tree <- renderEmptyTree()
  
	# An observer is used to trigger a tree update with new data.
	observe({
	  updated.tree<-jsonTree(input$idTree)
	  updateTree(session,"tree",updated.tree)
	})
})
