
# This file is a generated template, your changes will not be overwritten

# dichotomous model
#' @importFrom R6 R6Class
#' @import jmvcore
#' @importFrom TAM tam.jml
#' @importFrom TAM tam.jml.fit
#' @export


dichotomousClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "dichotomousClass",
    inherit = dichotomousBase,
    private = list(

#===========================================

.init = function() {
  
 
  if(is.null(self$data) | is.null(self$options$vars)){
    self$results$instructions$setVisible(visible = TRUE)
    
  }
  
  self$results$instructions$setContent(
    "<html>
            <head>
            </head>
            <body>
            <div class='instructions'>
            <p>Welcome to Dichotomous Rasch Model.</p>
            
            <p><b>To get started:</b></p>
            
            <p>- The input dataset require dichotomous data with the type of <b>numeric-continuous</b> in jamovi.</p>
            <p>- Just highlight the variables and click the arrow to move it across into the 'Variables' box.</p>
            
            <p>If you encounter any errors, or have questions, please e-mail me: snow@cau.ac.kr</a></p>
            </div>
            </body>
            </html>"
  )
  
#  private$.initItemsTable()
  
  if (length(self$options$vars) <= 1)
    self$setStatus('complete')
},
      
      

#======================================        
 .run = function() {

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)


# get variables---------------------------------
      
     data <- self$data  
     
     vars <- self$options$get('vars')
     
       
       # for(v in vars)
       # data[[v]] <- jmvcore::toNumeric(data[[v]])
       
                    
# compute item statistics with TAM package--------
      
    ready <- TRUE
    
    if (is.null(self$options$vars) || length(self$options$vars) < 2)
      ready <- FALSE
    
    if (ready) {
      
     data <- private$.cleanData()
    
     results <- private$.compute(data)
      
 # populate item table     
      
      private$.populateItemsTable(results)
   
     
    }
  },


# compute results---------------------------
    
.compute = function(data) {
  

  # get variables---------------------------------
  
  data <- self$data  
  
  vars <- self$options$get('vars')
  
  
  # for(v in vars)
  #   data[[v]] <- jmvcore::toNumeric(data[[v]])
  # 
  

   ### estimate the Rasch model with JML using function 'tam.jml'=================
      
 # estimate Item Total Score(Sufficient Statistics)
  
      itotal <- TAM::tam.jml(resp=data)$ItemScore             
                    
 # estimate item difficulty measure
      
      imeasure <-  TAM::tam.jml(resp=data)$xsi
      

# computing infit statistics--------------------------------
       
#  infit<- TAM::tam.jml.fit(tamobj =TAM::tam.jml(resp=data))$fit.item$infitItem

#computing outfit statistics-----------------------      
      
#   outfit <- TAM::tam.jml.fit(tamobj =TAM::tam.jml(resp=data))$fit.item$outfitItem
  
   
  results <- list('itotal'=itotal, 'imeasure'=imeasure)
     
    },

#### Init. tables ---------------------------------
   
   .initItemsTable = function() {
        
        table <- self$results$items
        
        for (i in seq_along(items))
          table$addFootnote(rowKey=items[i], 'name')
        
      },      
      

# populate item tables----------------------------
      
.populateItemsTable = function(results) {
  
  table <- self$results$items
  
  items <- self$options$vars
  
 
  itotal <- results$itotal
  imeasure <- results$imeasure
  
#  infit <- results$infit
#  outfit <- results$outfit
  
  for (i in seq_along(items)) {
    
    row <- list()

    
    row[["score"]] <- itotal[i,1]
    
    row[["measure"]] <- imeasure[i]
    
#     row[["infit"]] <- infit[i]
     
#     row[["outfit"]] <- outfit[i]
    
 
    table$setRow(rowKey=items[i], values=row)}
  
    },
  
  #### Helper functions ----
 
 .cleanData = function() {
     
     items <- self$options$vars
     
     data <- list()
  
        for (item in items)
       data[[item]] <- jmvcore::toNumeric(self$data[[item]])
     
     attr(data, 'row.names') <- seq_len(length(data[[1]]))
     attr(data, 'class') <- 'data.frame'
     data <- jmvcore::naOmit(data)

     return(data)   
          }
))
