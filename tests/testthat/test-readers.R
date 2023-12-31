context("Test Readers")

test_that("read_chromsize_file works", {
    chromsizefile <- system.file('extdata/CHROMSIZES',
                                 'hg18.txt',
                                 package = 'chromhmmData')
    res <- read_chromsize_file(chromsizefile)
    expect_true(is.data.frame(res))
    expect_true(is.character(res$seqname))
    expect_true(is.numeric(res$width))
})

inputdir <- system.file('extdata/SAMPLEDATA_HG18',
                        package = 'segmenter')
outputdir <- tempdir()
coordsdir <- system.file('extdata/COORDS',
                         package = 'chromhmmData')
anchorsdir <- system.file('extdata/ANCHORFILES',
                          package = 'chromhmmData')
chromsizefile <- system.file('extdata/CHROMSIZES',
                             'hg18.txt',
                             package = 'chromhmmData')
obj <- learn_model(inputdir = inputdir,
                   outputdir = outputdir,
                   coordsdir = coordsdir,
                   anchorsdir = anchorsdir,
                   chromsizefile = chromsizefile,
                   numstates = 3,
                   assembly = 'hg18',
                   cells = c('K562', 'GM12878'),
                   annotation = 'RefSeq',
                   binsize = 200)

test_that("read_segements_file works", {
    segmentfile <- file.path(outputdir, 'GM12878_3_segments.bed')
    res <- read_segements_file(segmentfile)

    expect_true(is.data.frame(res))
    expect_true(is.character(res$seqname))
    expect_true(is.character(res$state))
    expect_true(is.integer(res$start))
    expect_true(is.integer(res$end))

    states <- paste0('S', 1:3)
    res2 <- read_segements_file(segmentfile, states)
    expect_equal(as.numeric(as.factor(res$state)),
                 as.numeric(as.factor(res2$state)))
})

test_that("read_emissions_file works", {
    fl <- file.path(outputdir, 'emissions_3.txt') 

    res <- read_emissions_file(fl)
    states <- paste0('S', seq_len(nrow(res)))
    marks <- paste0('M', seq_len(ncol(res)))

    expect_true(is.matrix(res))
    expect_true(is.numeric(res))

    expect_equal(rownames(read_emissions_file(fl, states)),
                 states)
    expect_error(rownames(read_emissions_file(fl, c(states, states))))

    expect_equal(colnames(read_emissions_file(fl, marks = marks)),
                 marks)
    expect_error(colnames(read_emissions_file(fl, marks = c(marks, marks))))
})

test_that("read_transitions_file works", {
    fl <- file.path(outputdir, 'transitions_3.txt') 
    
    res <- read_transitions_file(fl)
    states <- paste0('S', seq_len(nrow(res)))

    expect_true(is.matrix(res))
    expect_true(is.numeric(res))

    expect_equal(rownames(read_transitions_file(fl, states)),
                 states)
    expect_error(rownames(read_transitions_file(fl, c(states, states))))

    expect_equal(colnames(read_transitions_file(fl, states)),
                 states)
    expect_error(colnames(read_transitions_file(fl, c(states, states))))
})

test_that("read_overlap_file works", {
    fl <- file.path(outputdir, 'GM12878_3_overlap.txt')

    res <- read_overlap_file(fl)
    states <- paste0('S', seq_len(nrow(res)))
    regions <- paste0('R', seq_len(ncol(res)))

    expect_true(is.matrix(res))
    expect_true(is.numeric(res))

    expect_equal(rownames(read_overlap_file(fl, states)),
                 states)
    expect_error(rownames(read_overlap_file(fl, c(states, states))))

    expect_equal(colnames(read_overlap_file(fl, regions = regions)),
                 regions)
    expect_error(colnames(read_overlap_file(fl, regions = c(regions, regions))))
})

test_that("read_enrichment_file works", {
    fl <- file.path(outputdir, 'GM12878_3_RefSeqTSS_neighborhood.txt')

    res <- read_enrichment_file(fl)
    states <- paste0('S', seq_len(nrow(res)))
    regions <- paste0('R', seq_len(ncol(res)))

    expect_true(is.matrix(res))
    expect_true(is.numeric(res))

    expect_equal(rownames(read_enrichment_file(fl, states)),
                 states)
    expect_error(rownames(read_enrichment_file(fl, c(states, states))))

    expect_equal(colnames(read_enrichment_file(fl, regions = regions)),
                 regions)
    expect_error(colnames(read_enrichment_file(fl, regions = c(regions, regions))))
})

test_that("read_model_file works.", {
    fl <- file.path(outputdir, 'model_3.txt')

    res <- read_model_file(fl)

    expect_true(is.list(res))
})

test_that("read_model_file works.", {
    fl <- system.file('extdata/SAMPLEDATA_HG18/',
                      'GM12878_chr11_binary.txt.gz',
                      package = 'segmenter')
    res <- read_bins_file(fl)

    expect_true(is.list(res))
    expect_true(is.character(res$cell))
    expect_true(is.character(res$seqname))
    expect_true(is.data.frame(res$binaries))
})

test_that("read_cellmark_file works.", {
    fl <- system.file('extdata',
                      'cell_mark_table.tsv',
                      package = 'segmenter')

    df <- read_cellmark_file(fl)
    expect_true(is.data.frame(df))
    expect_equal(nrow(df), 4)
    expect_equal(ncol(df), 3)
})

test_that("read_bam_file works.", {
    bam_file <- system.file("extdata",
                            "randomBam.bam",
                            package = "bamsignals")
    rand_anno <- system.file("extdata",
                             "randomAnnot.Rdata",
                             package = "bamsignals")
    features <- GenomicRanges::promoters(get(load(rand_anno)))
    reads <- read_bam_file(bam_file, features)

    expect_true(is.integer(reads))
    expect_equal(length(reads), length(features))
})
