% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualization.R
\name{plot_heatmap}
\alias{plot_heatmap}
\title{Visualize the model output}
\usage{
plot_heatmap(obj, type = "emission", ...)
}
\arguments{
\item{obj}{A segmentation object}

\item{type}{A string. Which kind of parameter to print. Default is 'emission'
and possible values are 'emission', 'transition', 'overlap', 'TSS' or 'TES'}

\item{...}{Other arguments to path to Heatmap}
}
\value{
A heatmap
}
\description{
Visualize the model output
}
\examples{
plot_heatmap(test_obj)

}
