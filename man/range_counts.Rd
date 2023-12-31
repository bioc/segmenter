% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{range_counts}
\alias{range_counts}
\title{Format the loaded counts data}
\usage{
range_counts(
  counts,
  features,
  return = "GRanges",
  tidy = FALSE,
  average = FALSE,
  marks
)
}
\arguments{
\item{counts}{A \code{matrix} of the \code{read_bam_file} output.}

\item{features}{A \code{GRanges}. That was used to count the bam files.}

\item{return}{A string. Possible values are \code{GRanges} (default) or
\code{SummarizedExperiment}.}

\item{tidy}{A \code{logical}. Default is \code{TRUE}. Whether to tidy the
metadata columns of the \code{GRanges} object.}

\item{average}{A \code{logical}. Default is \code{FALSE}. Whether to average
the counts by \code{marks} before building the object.}

\item{marks}{A \code{character} vector. The length shoud equal the numbe of
columns in \code{counts} and is used for averaging and renaming the matrix
columns.}
}
\value{
\code{GRanges} (default) or \code{SummarizedExperiment}.
}
\description{
The function takes the \code{data.frame}s of the loaded counts data and
format them into \code{GRanges} or \code{SummarizedExperiment} objects.
}
