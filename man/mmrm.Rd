% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit.R
\name{mmrm}
\alias{mmrm}
\title{Fit an MMRM}
\usage{
mmrm(
  formula,
  data,
  weights = NULL,
  covariance = NULL,
  reml = TRUE,
  control = mmrm_control(...),
  ...
)
}
\arguments{
\item{formula}{(\code{formula})\cr the model formula, see details.}

\item{data}{(\code{data})\cr the data to be used for the model.}

\item{weights}{(\code{vector})\cr an optional vector of weights to be used in
the fitting process. Should be \code{NULL} or a numeric vector.}

\item{covariance}{(\code{cov_struct})\cr a covariance structure type definition
as produced with \code{\link[=cov_struct]{cov_struct()}}, or value that can be coerced to a
covariance structure using \code{\link[=as.cov_struct]{as.cov_struct()}}. If no value is provided,
a structure is derived from the provided formula.}

\item{reml}{(\code{flag})\cr whether restricted maximum likelihood (REML)
estimation is used, otherwise maximum likelihood (ML) is used.}

\item{control}{(\code{mmrm_control})\cr fine-grained fitting specifications list
created with \code{\link[=mmrm_control]{mmrm_control()}}.}

\item{...}{arguments passed to \code{\link[=mmrm_control]{mmrm_control()}}.}
}
\value{
An \code{mmrm} object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This is the main function fitting the MMRM.
}
\details{
The \code{formula} typically looks like:
\code{FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID)}
so specifies response and covariates as usual, and exactly one special term
defines which covariance structure is used and what are the time point and
subject variables. The covariance structures in the formula can be
found in \code{\link{covariance_types}}.

The time points have to be unique for each subject. That is,
there cannot be time points with multiple observations for any subject.
The rationale is that these observations would need to be correlated, but it
is not possible within the currently implemented covariance structure framework
to do that correctly.

When optimizer is not set, first the default optimizer
(\code{L-BFGS-B}) is used to fit the model. If that converges, this is returned.
If not, the other available optimizers from \code{\link[=h_get_optimizers]{h_get_optimizers()}},
including \code{BFGS}, \code{CG} and \code{nlminb} are
tried (in parallel if \code{n_cores} is set and not on Windows).
If none of the optimizers converge, then the function fails. Otherwise
the best fit is returned.

Note that fine-grained control specifications can either be passed directly
to the \code{mmrm} function, or via the \code{control} argument for bundling together
with the \code{\link[=mmrm_control]{mmrm_control()}} function. Both cannot be used together, since
this would delete the arguments passed via \code{mmrm}.
}
\note{
The \code{mmrm} object is also an \code{mmrm_fit} and an \code{mmrm_tmb} object,
therefore corresponding methods also work (see \code{\link{mmrm_tmb_methods}}).

Additional contents depend on the choice of the adjustment \code{method}:
\itemize{
\item If Satterthwaite adjustment is used, the Jacobian information \code{jac_list}
is included.
\item If Kenward-Roger adjustment is used, \code{kr_comp} contains necessary
components and \code{beta_vcov_adj} includes the adjusted coefficients covariance
matrix.
}

Use of the package \code{emmeans} is supported, see \code{\link{emmeans_support}}.
}
\examples{
fit <- mmrm(
  formula = FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID),
  data = fev_data
)

# Direct specification of control details:
fit <- mmrm(
  formula = FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID),
  data = fev_data,
  weights = fev_data$WEIGHTS,
  method = "Kenward-Roger"
)

# Alternative specification via control argument (but you cannot mix the
# two approaches):
fit <- mmrm(
  formula = FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID),
  data = fev_data,
  control = mmrm_control(method = "Kenward-Roger")
)
}
