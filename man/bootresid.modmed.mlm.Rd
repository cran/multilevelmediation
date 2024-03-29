% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modmedmlm.R
\name{bootresid.modmed.mlm}
\alias{bootresid.modmed.mlm}
\title{Custom function for residual bootstrap for (moderated) multilevel mediation}
\usage{
bootresid.modmed.mlm(
  data,
  L2ID,
  R = 1000,
  X,
  Y,
  M,
  moderator = NULL,
  covars.m = NULL,
  covars.y = NULL,
  ...,
  type = "all",
  modval1 = NULL,
  modval2 = NULL
)
}
\arguments{
\item{data}{Data frame in long format.}

\item{L2ID}{Name of column that contains grouping variable in 'data' (e.g., "SubjectID")}

\item{R}{Number of resamples}

\item{X}{(Character) Name of column that contains the X independent variable in \code{data}.}

\item{Y}{(Character) Name of column that contains the Y dependent variable in \code{data}.}

\item{M}{(Character) Name of column that contains the M mediating variable in \code{data}.}

\item{moderator}{Optional Character that contains name of column that contains the moderator variable in \code{data}}

\item{covars.m}{(Character vector) Optional covariates to include in the model for M.}

\item{covars.y}{(Character vector) Optional covariates to include in the model for Y.}

\item{...}{Arguments passed to \code{\link{modmed.mlm}} to define the mediation analysis model.}

\item{type}{Character that defines what information to extract from the model. Default and options are in \code{\link{extract.modmed.mlm}}.
As examples, "indirect" will compute the indirect effect, "all" will save all random and fixed effects for possible additional
computations, "indirect.diff" will compute the difference in the indirect effect at two values of a possible moderating variable.}

\item{modval1}{(Optional) Numeric. If the model has a moderator, this value will be passed to \code{\link{extract.modmed.mlm}}
to compute the indirect effect or other effects at that value. See \code{extract.modmed.mlm} for details.}

\item{modval2}{(Optional). If the model has a moderator, it is possible to compute the difference in the indirect
at two values of the moderator. If given and an appropriate option for such a difference is chosen for \code{type},
this value and that of \code{modval1} will be passed to \code{\link{extract.modmed.mlm}} to compute and save the difference.
This is useful for obtaining a CI for the difference in the indirect effect at two different levels of the moderator.}
}
\value{
A list with the following elements. Note that \code{t0} and \code{t} are intended to trick the \code{\link[boot]{boot}}
  package into working with some if its functions.
\itemize{
 \item{\code{t0} Parameter estimates based on the dataset.}
 \item{\code{t} Bootstrap distribution of all parameter estimates.}
 \item{\code{model} Fitted model to restructured data as one would obtain from \code{modmed.mlm}.}
 \item{\code{call} Call/arguments used when invoking this function. Useful for later extracting things like indirect effect.}
}
}
\description{
Custom function for residual bootstrap for (moderated) multilevel mediation
}
\details{
This function restructures data following Bauer, Pearcher, & Gil (2006) and then conducts residual-based
bootstrapping in order to later obtain confidence intervals for the indirect effect and other coefficients.
The residual-based bootstrap is described in Falk, Vogel, Hammami, & Miočević's manuscript (in press), but
generally follows the procedure by Carpenter, Goldstein, & Rashbash (2003; See also Lai, 2021). Currently this function
does not support parallel processing. See the newer \code{\link{boot.modmed.mlm.custom}} version for a re-write that does.
}
\examples{
\donttest{
# Example data for 1-1-1 w/o moderation
data(BPG06dat)

# Note that R should be set to something MUCH larger, such as 1000 or greater.
# A low number here is chosen only so testing this example code goes relatively
# quickly
bootresid <- bootresid.modmed.mlm(BPG06dat,L2ID="id", X="x", Y="y", M="m",
  R=5, random.a=TRUE, random.b=TRUE, random.cprime=TRUE,
  control=list(opt="nlm")
  )

extract.boot.modmed.mlm(bootresid, type="indirect")


}
}
\references{
Bauer, D. J., Preacher, K. J., & Gil, K. M. (2006). Conceptualizing and testing random indirect		effects and moderated mediation in multilevel models: new procedures and	recommendations. Psychological Methods, 11(2), 142-163. \doi{10.1037/1082-989X.11.2.142}

Carpenter, J. R., Goldstein, H., & Rasbash, J. (2003). A novel bootstrap procedure for assessing the relationship between class size and achievement. Applied Statistics, 52(4), 431-443.

Falk, C. F., Vogel, T., Hammami, S., & Miočević, M. (in press). Multilevel mediation analysis in R: A comparison of bootstrap and Bayesian approaches. Behavior Research Methods. \doi{10.3758/s13428-023-02079-4}  Preprint: \doi{10.31234/osf.io/ync34}

Lai, M. (2021). Bootstrap confidence intervals for multilevel standardized effect size. Multivariate Behavioral Research, 56(4), 558-578. \doi{10.1080/00273171.2020.1746902}
}
