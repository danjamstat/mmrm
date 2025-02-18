% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/residual.R
\name{h_df_md_res}
\alias{h_df_md_res}
\title{Calculation of Residual Degrees of Freedom for Multi-Dimensional Contrast}
\usage{
h_df_md_res(object, contrast)
}
\arguments{
\item{object}{(\code{mmrm})\cr object.}

\item{contrast}{(\code{matrix})\cr contrast matrix.}
}
\value{
List with \code{num_df}, \code{denom_df}, \code{f_stat} and \code{p_val} (2-sided p-value).
}
\description{
Calculates the residual degrees of freedom, F statistic and p value for multi-dimensional contrast.
Used in \code{\link[=df_md]{df_md()}} if method is "Residual".
}
\keyword{internal}
