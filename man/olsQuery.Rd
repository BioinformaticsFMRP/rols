% Generated by roxygen2 (4.0.2): do not edit by hand
\name{olsQuery}
\alias{olsQuery}
\title{Returns matching identifiers}
\usage{
olsQuery(pattern, ontologyName, exact = FALSE, n = 3, simplify = TRUE)
}
\arguments{
\item{pattern}{A \code{character} used to query the OLS.}

\item{ontologyName}{Optional. A \code{character} with the name of
a valid ontology name. If missing, all ontologies are searched for
\code{pattern}.}

\item{exact}{Require pattern to match term exactly. Default is
FALSE. Note that if \code{ontologyName} is missing, exact is
ignored.}

\item{n}{Number of attempts to repeat the query if no result is
found. Default is 3.}

\item{simplify}{A logical indicating whether the S4 \code{Map}
instance should be simplified. Default is \code{TRUE}.}
}
\value{
A named \code{character} if \code{simplify} is \code{TRUE}.
An instance of class \code{Map} otherwise.
}
\description{
This function queries one or all ontologies for a pattern
and returns all identifiers/terms. If a valid \code{ontologyName}
is provided, only that ontology is queried. The function then sends a
\code{getTermsByNameRequest} SOAP message
and retrieves and parses the \code{getTermsByNameResponse}.
The original corresponging interface is
\code{public Map getTermsByName(String partialName, String ontologyName, boolean reverseKeyOrder)}.
If no \code{ontologyName} is provided, all ontologies are used; the function then
sends a \code{getPrefixedTermsByNameRequest} SOAP message
and retrieves and parses the \code{getPrefixedTermsByNameResponse}.
The original corresponging interface is
\code{public Map getPrefixedTermsByName(String partialName, boolean reverseKeyOrder)}.
}
\details{
Some valid queries sometimes return empty results due to network instabilities.
For this reason, each \code{olsQuery} is repeated 3 times (see \code{n} parameter)
as long as empty resuls are obtained. In general, when the ontology is specified,
queries are fast and reliable.
}
\examples{
olsQuery("tgn","GO") ## search GO for 'tgn'
olsQuery("tgn") ## search all ontologies
olsQuery("ESI", "MS")
olsQuery("ESI", "MS", exact = TRUE)
}
\author{
Laurent Gatto
}
\seealso{
Other ols-queries: \code{\link{allIds}};
  \code{\link{isIdObsolete}}; \code{\link{olsVersion}};
  \code{\link{ontologies}}; \code{\link{ontologyLoadDate}};
  \code{\link{ontologyNames}}; \code{\link{rootId}};
  \code{\link{termMetadata}}; \code{\link{termXrefs}};
  \code{\link{term}}
}

