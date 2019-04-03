\name{update-methods}
\docType{methods}
\alias{update}
\title{
  Updating a powCalc or a power object.
}
\description{
  A function for updating an existing object of class \code{powCalc} or
  \code{power}.
}
\usage{update(object, ...)}

\arguments{
  \item{object}{An object of class \code{powCalc} or \code{power}.}
  \item{...}{The following elements (slots) of the object can be
    updated:
    \describe{
      \item{n.iter}{A number indicating the number of iterations used to
	dertermine the power if the calcualation is based on
	resamlpling.
	The existing iterations will be kept. Therefore after evaluation
	the number of iterations will be \code{n.iter}.}
      \item{n}{A vector with numbers for evaluating the power.
	New elements will be evaluated and existing elements reused.
	If some elements of the original are not part of \code{n} they
	will be ommitted.}
      \item{theta}{see \code{n} for details.}
      \item{xi}{see \code{n} for details.}
      \item{statistic}{A function of an object of class \code{psi}.
	If a new statistic is provided all elements will be evaluated
	again.}
    }
  }
}
\note{Be careful if you use this function to update objects of class
  \code{power}.}
\value{An object of class \code{powCalc}.}
\seealso{\code{\link{powCalc}} for geneating new objcets of class
  \code{powCalc}.}
\examples{
## defining the range of n and theta to be evaluated
psi <- powPar(theta = seq(from = 0.5, to = 1.5, by = 0.1),
              n = seq(from = 20, to = 60, by = 2),
              muA = 0,
              muB = 1)

## defining a power-function     
powFun <- function(psi){
  power.t.test(n = n(psi)/2,
               delta = pp(psi, "muA") - pp(psi, "muB"),
               sd = theta(psi)
               )$power
}

## evaluating the power-function for all combinations of n and theta
calc <- powCalc(psi, powFun)

## updating by using additional elements for "n"
calc2 <- update(calc, n = seq(from = 20, to = 90, by = 2))

## adding example at theta of 1 and power of 0.9
pow <- powEx(calc2, theta = 1, power = 0.9)

## drawing the power plot with 3 contour lines
plot(pow,
     xlab = "Standard Deviation",
     ylab = "Total Sample Size",
     at = c(0.85, 0.9, 0.95))
}
\keyword{methods}