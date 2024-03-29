% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/long_xx_transmat.R
\name{transmat_to_long}
\alias{transmat_to_long}
\title{Transition matrix to long format}
\usage{
transmat_to_long(probs)
}
\arguments{
\item{probs}{Probability transition matrix}
}
\value{
array of from, to, prob
}
\description{
Transition matrix to long format
}
\examples{

tree <- list(
   prob = matrix(data = c(NA, 0.5, 0.5), nrow = 1),
   vals = matrix(data = c(NA, 1, 2), nrow = 1))

transmat_to_long(tree$prob)

}
