# CalledStrikeNew

R package for manipulating, modeling, and visualizing Statcast pitching data.

The Statcast collection functions based on the baseballr package are removed.

This package only contains the smoothing and graphing functions.

![GitHub Logo](/images/freeman.png)

To install:

library(remotes)

install_github("bayesball/CalledStrikeNew")

When the package is loaded, can see graphs for some sample data:

library(CalledStrikeNew)

ShinyDemo()
