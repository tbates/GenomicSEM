#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom lavaan lavaan sem standardizedSolution parTable lavInspect 
#' @importFrom lavaan lav_model_get_parameters lav_matrix_vech
#' @importFrom lavaan lav_func_jacobian_complex simulateData

#' @importFrom foreach %dopar% foreach %:% 
#' @importFrom iterators icount
#' @importFrom data.table := %like% fread setnames transpose
#' @importFrom dplyr %>% filter mutate select summarise across all_of 
#' @importFrom dplyr anti_join inner_join count where
#' @importFrom gdata lowerTriangle upperTriangle
#' @importFrom ggpubr ggarrange ggexport
#' @importFrom ggplot2 aes ggplot geom_abline geom_hline geom_line geom_point
#' @importFrom ggplot2 geom_ribbon geom_segment geom_text geom_tile geom_vline
#' @importFrom ggplot2 scale_color_manual scale_fill_gradient2 scale_fill_manual
#' @importFrom ggplot2 scale_shape_manual scale_size scale_x_continuous
#' @importFrom ggplot2 scale_x_discrete scale_y_continuous
#' @importFrom ggplot2 labs guides guide_colorbar coord_cartesian
#' @importFrom ggplot2 element_blank element_line element_text stat_function
#' @importFrom ggplot2 ggsave theme theme_bw theme_classic theme_minimal
#' @importFrom grDevices colorRampPalette
#' @importFrom Matrix nearPD
#' @importFrom matrixStats rowQuantiles
#' @importFrom MASS mvrnorm
#' @importFrom doParallel registerDoParallel
#' @importFrom parallel makeCluster stopCluster detectCores mclapply
#' @importFrom plyr ldply
#' @importFrom readr read_delim read_csv
#' @importFrom R.utils gzip
#' @importFrom rlang .data
#' @importFrom stringr str_count str_detect str_remove_all str_replace_all
#' @importFrom tictoc tic toc
#' @importFrom utils combn capture.output install.packages installed.packages
#' @importFrom utils read.table write.table object.size txtProgressBar
#' @importFrom utils setTxtProgressBar lsf.str tail
#' @importFrom stats cor cov cov2cor dnorm pnorm qnorm pchisq qchisq
#' @importFrom stats lm median na.omit optim resid fitted setNames

# replace plyr::ldply with dply function or purrr

## usethis namespace: end

utils::globalVariables(c(
	"eigenvalue",
    "highlight",
	"n",
	"Indicator",
	"LDsc",
	"Predictors",
	"RMATRIX",
	"SEs",
	"SEss",
	"SNP",
	"Value",
	"Variable",
	"Z",
	"Z.x",
	"Z.y",
	"h11",
	"h22",
	"lam",
	"lat_labs",
	"num",
	"op",
	"r",
	"rGs",
	"slope",
	"type",
	"nsnps.list.imputed",
	"snps.list.imputed.vector",
	"n",
	"inspect",
	"fixed",
	"type",
	"slope"
))
NULL


