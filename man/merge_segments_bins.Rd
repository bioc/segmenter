% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{merge_segments_bins}
\alias{merge_segments_bins}
\title{Merge segments and bins objects}
\usage{
merge_segments_bins(segments, bins)
}
\arguments{
\item{segments}{A \code{GRanges} object. Usually the output of calling
\code{segment} on the the output object of \code{lean_model}.}

\item{bins}{A \code{SummarizedExperiment} object. Usually the output of
calling \code{bins} on the the output object of \code{lean_model}.}
}
\value{
A \code{SummarizedExperiment} object with the segment assignment
added to the metadata of the \code{rowRanges}.
}
\description{
Merge segments and bins objects
}
