\name{home_run_contour}
\alias{home_run_contour}

\title{
  Home Run Contour Plot
}
\description{
  Constructs home run contour plot for a specific player
}
\usage{
  home_run_contour(df, L = seq(0.04, 0.24, by = 0.04), title, NCOL = 2)
}
\arguments{
  \item{df}{
    data frame or list containing Statcast data
  }
  \item{L}{
    values for the contour lines
  }
  \item{title}{
    title of the graph
  }
  \item{NCOL}{
    number of columns in multipanel display
  }
}
\value{
  Constructs a contour plot of the home run probability
}
\author{
  Jim Albert
}


