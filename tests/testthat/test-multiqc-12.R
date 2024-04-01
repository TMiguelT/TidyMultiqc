test_that("xy_line plots are parsed identically", {
  old <- system.file("extdata", "wgs", "multiqc_data.json", package = "TidyMultiqc") %>% TidyMultiqc::load_multiqc(sections = "plot", plots = "qualimap_coverage_histogram")
  new <- system.file("extdata", "1.2_wgs", "multiqc_data.json", package = "TidyMultiqc") %>% TidyMultiqc::load_multiqc(sections = "plot", plots = "qualimap_coverage_histogram")
  testthat::expect_identical(old, new)
})

test_that("bar plots are parsed identically", {
  old <- system.file("extdata", "wgs", "multiqc_data.json", package = "TidyMultiqc") %>% TidyMultiqc::load_multiqc(sections = "plot", plots = "snpeff_variant_effects_region")
  new <- system.file("extdata", "1.2_wgs", "multiqc_data.json", package = "TidyMultiqc") %>% TidyMultiqc::load_multiqc(sections = "plot", plots = "snpeff_variant_effects_region")
  # Check that the samples are identical and in the right order
  testthat::expect_identical(old$metadata.sample_id, new$metadata.sample_id)
  # Check that each tibble inside the plot column is mapequal. Namely, ignore differences in list order, since hopefully users
  # are accessing these elements by name and not by position
  purrr::map2(old$plot.snpeff_variant_effects_region, new$plot.snpeff_variant_effects_region, testthat::expect_mapequal)
})
