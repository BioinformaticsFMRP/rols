rolsDeprecationMessage <- function() {    
    msg <- paste("The onology lookup service, the backend behind rols has",
                 "been updated (see http://www.ebi.ac.uk/ols/beta/roadmap.html).",
                 "As a result, the rols package is being re-implemented and ",
                 "will undergo changes in its user interface. The current",
                 "interface will be maintained for Bioconductor release 3.2",
                 "and will be discontinued afterwards. Please see",
                 "https://github.com/lgatto/rols/tree/v2.0 for the new release.")
    message(cat(strwrap(msg), sep = "\n"))
}


##' \code{key} slot accessor for the \code{mapItem} instances.
##'
##' @name key,mapItem-method
##' @aliases key
##' @rdname key-methods
##' @docType methods
##' @title \code{key} slot accessor.
##' @param object An instance of class \code{Map} or \code{mapItem}.
##' @return A \code{character}.
##' @exportMethod key
setMethod("key", "mapItem", function (object) object@key)

##' \code{value} slot accessor for the \code{mapItem} instances.
##'
##' @name value,mapItem-method
##' @aliases value
##' @rdname value-methods
##' @docType methods
##' @title \code{value} slot accessor.
##' @param object An instance of class \code{Map} or \code{mapItem}.
##' @return A \code{character}.
##' @exportMethod value
setMethod("value", "mapItem", function (object) object@value)


##' \code{key} slot accessor for the \code{Map} instances.
##'
##' @name key,Map-method
##' @aliases key
##' @rdname key-methods
##' @docType methods
##' @title \code{key} slot accessor.
##' @return A \code{character}.
##' @author Laurent Gatto
##' @exportMethod key
setMethod("key", "Map", function (object) sapply(object, key))

##' \code{value} slot accessor for the \code{Map} instances.
##'
##' @name value,Map-method
##' @aliases value
##' @rdname value-methods
##' @docType methods
##' @title \code{value} slot accessor.
##' @return A \code{character}.
##' @author Laurent Gatto
##' @exportMethod value
setMethod("value", "Map", function (object) sapply(object, value))



##' Accessor for the \code{Map} data of the OLS
##' return messages converted to their respective
##' S4 classes. The actual data is stored in \code{Map}
##' slots.
##'
##' @name map,ANY-method
##' @aliases map
##' @rdname map-methods
##' @docType methods
##' @title \code{Map} slot accessor.
##' @param object An S4 class produced by an OLS return message.
##' @return A instance of class \code{Map}.
##' @author Laurent Gatto
##' @exportMethod map
setMethod("map", "ANY",
          function(object) {
            sn <- slotNames(object)
            stopifnot(length(sn) == 1)
            ans <- slot(object, sn)
            stopifnot(class(ans) == "Map")
            return(ans)
          })

setAs("Map", "character",
            function (from, to = "character") {
              ans <- sapply(from, slot, "value")
              names(ans) <- sapply(from, slot, "key")
              ans
            })

##' \code{as} method to coerce an instance of \code{Map}
##' to a \code{character}. The maps keys are used to name
##' the map values.
##'
##' @title Coerce \code{Map} to a \code{data.frame}
##' @param x An instance \code{Map}.
##' @param ... not used.
##' @return A \code{character} of length \code{length(map)}.
##' @author Laurent Gatto
##' @method as.character Map
##' @export
##' @family as
as.character.Map <- function(x, ...) as(x, "character")


setAs("mapItem", "character",
      function (from, to = "character") {
        ans <- c(from@key,
                 from@value)
        names(ans) <- c("Key","Value")
        ans
      })

##' \code{as} method to coerce an instance of \code{mapItem}
##' to a \code{character} by concatenating the \code{key}
##' and \code{value} variabels.
##'
##' @title Coerce \code{mapItem} to a \code{character}
##' @param x An instance of \code{mapItem}.
##' @param ... not used
##' @return A \code{character} of length 2.
##' @author Laurent Gatto
##' @method as.character mapItem
##' @export
##' @family as
as.character.mapItem <- function(x, ...) as(x, "character")


##' show method for \code{Map} instances
##'
##' @name show,Map-method 
##' @aliases show show?Map
##' @docType methods
##' @rdname show-methods
##' @title \code{Map} show method
##' @param object An \code{Map} instance.
##' @return Returns an invisible 'NULL'. This function is used
##' for its side-effect of printing a textual description
##' of \code{object}.
##' @author Laurent Gatto
##' @exportMethod show
setMethod("show", "Map",
          function (object) {
            l <- length(object)
            if (l == 0) {
              cat("Empty object of class \"",class(object),"\"\n",sep="")             
            } else {
              cat("Object of class \"",class(object),"\"",sep="")
              cat(" with ", length(object)," items:\n", sep="")            
              k <- sapply(object, function(x) x@key)
              v <- sapply(object, function(x) x@value)
              if (l == 1) {
                  cat(" Key:   ", k[1], ".\n", sep="")
                  cat(" Value: ", v[1], ".\n", sep="")
              } else if (l == 2) {
                  cat(" Keys:   ", paste0(k[1:2], collapse=", "), ".\n")
                  cat(" Values: ", paste0(v[1:2], collapse=", "), ".\n")
              } else {
                  cat(" Keys:   ", paste0(k[1:2], collapse=", "), ", ...\n")
                  cat(" Values: ", paste0(v[1:2], collapse=", "), ", ...\n")
              }
          }
            invisible(NULL)
          })
