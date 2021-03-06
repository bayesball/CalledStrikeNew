\name{woba_contour}
\alias{woba_contour}

\title{
  wOBA Contour Plot
}
\description{
  Constructs wOBA angle contour graph
}
\usage{
  woba_contour(df, L = seq(0, 0.8, by = 0.05), title = "Average wOBA", NCOL = 2)
}
\arguments{
  \item{df}{
    data frame or list containing Statcast data
  }
  \item{L}{
    values for contour lines
  }
  \item{title}{
    title of graph
  }
  \item{NCOL}{
    number of columns in multipanel display
  }
}
\value{
  Constructs a contour plot of the launch angles
}
\author{
  Jim Albert
}


