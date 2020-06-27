
# This file is a generated template, your changes will not be overwritten

# dichotomous model
#' @importFrom R6 R6Class
#' @import jmvcore
#' @importFrom eRm RM 
#' @importFrom TAM tam.jml
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
  if (length(self$options$vars) <= 1)
    self$setStatus('complete')
},
      
      

#======================================        
 
  .run = function() {

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)


# get variables---------------------------------
      
      vars <- self$options$get('vars')

      data <- self$data
      
      for(v in vars)
      data[[v]] <- jmvcore::toNumeric(data[[v]])
      
                    
# compute person and item measure with TAM package--------
      
     
      # estimate the Rasch model with JML (function 'tam.jml')
      
      # estimate person measure
      person <- TAM::tam.jml(resp=data)$theta             
                    
     # estimate item measure
      item <-  TAM::tam.jml(resp=data)$item
      
# eRm package------------
      
   #   res<- eRm::RM(mydata)$betapar
      
      
# populate result----------------------------
      
      self$results$text1$setContent(person)
      
      self$results$text2$setContent(item)
      
      # self$results$text2$setContent(item)
 
                    
        })
)
