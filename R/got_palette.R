#' 'Game of Thrones' colour map
#'
#' A dataset containing the colour palettes from the TV show 'Game of Thrones'.
#'
#'@format A data frame containing all the colours used in the palette:
#'\itemize{
#'   \item V1: Red value
#'   \item V2: Green value
#'   \item V3: Blue value
#'   \item option: Refers to the houses of Westeros, or other colourmaps. It is intended to be a general option for choosing the specific colour palette.
#'}
"got.map"

# One colour ramp per option, built on first use. Filtering the 222k-row map and fitting the
# spline is the slow part of got(), and ggplot calls it on every scale build.
ramps <- new.env(parent = emptyenv())

got_ramp <- function(option) {
	if (is.null(ramps[[option]])) {
		map <- got.map[got.map$option == option, ]
		map_cols <- grDevices::rgb(map$V1, map$V2, map$V3, maxColorValue = 255)
		ramps[[option]] <- grDevices::colorRamp(map_cols, space = "Lab", interpolate = "spline")
	}
	ramps[[option]]
}

#' Game of Thrones Colour Map.
#'
#' This function creates a vector of \code{n} equally spaced colors along the
#' 'got colour map'.
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in `[0,1]`, see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in `[0,1]` at which the got colormap begins.
#'
#' @param end The (corrected) hue in `[0,1]` at which the got colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are ordered from darkest to lightest. If -1, the order of colors is reversed.
#'
#' @param option A character string indicating the colourmap to use. It is not case-sensible
#'
#' @return \code{got} returns a character vector, \code{cv}, of color hex
#' codes. This can be used either to create a user-defined color palette for
#' subsequent graphics by \code{palette(cv)}, a \code{col =} specification in
#' graphics functions or in \code{par}.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}, \href{https://aljrico.github.io}{Personal Blog}
#'
#' @details
#'
#' Here are the color scales:
#'
#' ![](got-scales.png)
#'
#' Semi-transparent colors (\eqn{0 < alpha < 1}) are supported only on some
#' devices: see \code{\link[grDevices]{rgb}}.
#'
#' @examples
#' library(ggplot2)
#' library(hexbin)
#'
#' dat <- data.frame(x = rnorm(1e4), y = rnorm(1e4))
#'
#' ggplot(dat, aes(x = x, y = y)) +
#'   geom_hex() + coord_fixed() +
#'   scale_fill_gradientn(colours = got(128, option = "targaryen")) +
#'   theme_minimal()
#'
#' pal <- got(256, option = "Wildfire")
#' image(volcano, col = pal)
#'
#' @export
got <- function(n, alpha = 1, begin = 0, end = 1, direction = 1, option = "Daenerys") {

	if (begin < 0 | begin > 1 | end < 0 | end > 1) {
		stop("begin and end must be in [0,1]")
	}

	if (abs(direction) != 1) {
		stop("direction must be 1 or -1")
	}

	stops <- seq(begin, end, length.out = n)
	if (direction == -1) stops <- rev(stops)

	cols <- got_ramp(tolower(option))(stops) / 255
	grDevices::rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha)
}

#' @rdname got
#' @export
got_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, option = "Daenerys") {
	function(n) {
		got(n, alpha, begin, end, direction, option)
	}
}

#' @rdname got
#' @export
gameofthrones <- got

#' Game of Thrones colour scales
#'
#' Uses the Game of Thrones color scale.
#'
#' For \code{discrete == FALSE} (the default) all other arguments are as to
#' \link[ggplot2]{scale_fill_gradientn} or \link[ggplot2]{scale_color_gradientn}.
#' Otherwise the function will return a \code{discrete_scale} with the plot-computed
#' number of colors.
#'
#' @param ... parameters to \code{discrete_scale} or \code{scale_fill_gradientn}
#'
#' @param alpha pass through parameter to \code{got}
#'
#' @param begin The (corrected) hue in `[0,1]` at which the got colormap begins.
#'
#' @param end The (corrected) hue in `[0,1]` at which the got colormap ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default, colors
#' are as output by \code{got_pal}. If -1, the order of colors is reversed.
#'
#' @param discrete generate a discrete palette? (default: \code{FALSE} - generate continuous palette)
#'
#' @param option A character string indicating the colourmap to use.
#'
#' @param aesthetics Character string or vector of character strings listing the name(s) of the aesthetic(s) that this scale works with.
#' This can be useful, for example, to apply colour settings to the `colour` and `fill` aesthetics at the same time, via `aesthetics = c("colour", "fill")`.
#' Parameter inherited from 'ggplot2'.
#'
#' @return A 'ggplot2' scale object (a `ggproto` object inheriting from `Scale`)
#' that sets the colours of a plot when added to it with `+`. The `_d` functions,
#' and the others when `discrete = TRUE`, return a discrete scale (class
#' `ScaleDiscrete`) that takes one colour from the palette per data level. The
#' others return a continuous scale (class `ScaleContinuous`) that maps numeric
#' values onto a gradient of the palette.
#'
#' @author Alejandro Jiménez Rico \email{aljrico@@gmail.com}
#'
#' @examples
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(factor(cyl), fill=factor(vs))) +
#' geom_bar() +
#' scale_fill_got(discrete = TRUE, option = "Daenerys")
#'
#' ggplot(mtcars, aes(factor(gear), fill=factor(carb))) +
#' geom_bar() +
#' scale_fill_got(discrete = TRUE, option = "Tully")
#'
#' ggplot(mtcars, aes(x = mpg, y = disp, colour = hp)) +
#' geom_point(size = 2) +
#' scale_colour_got(option = "Lannister")
#'
#' @name scale_got
NULL

#' @rdname scale_got
#' @export
scale_colour_got <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
														 discrete = FALSE, option = "Daenerys") {
	if (discrete) {
		scale_colour_got_d(..., alpha = alpha, begin = begin, end = end, direction = direction, option = option)
	} else {
		ggplot2::scale_colour_gradientn(colours = got(256, alpha, begin, end, direction, option), ...)
	}
}

#' @rdname scale_got
#' @export
scale_color_got <- scale_colour_got

#' @rdname scale_got
#' @export
scale_fill_got <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
													 discrete = FALSE, option = "Daenerys") {
	if (discrete) {
		scale_fill_got_d(..., alpha = alpha, begin = begin, end = end, direction = direction, option = option)
	} else {
		ggplot2::scale_fill_gradientn(colours = got(256, alpha, begin, end, direction, option), ...)
	}
}

#' @rdname scale_got
#' @export
scale_colour_got_d <- function(..., alpha = 1, begin = 0, end = 1,
															 direction = 1, option = "Daenerys", aesthetics = "colour") {
	ggplot2::discrete_scale(aesthetics, palette = got_pal(alpha, begin, end, direction, option), ...)
}

#' @rdname scale_got
#' @export
scale_color_got_d <- scale_colour_got_d

#' @rdname scale_got
#' @export
scale_fill_got_d <- function(..., alpha = 1, begin = 0, end = 1,
														 direction = 1, option = "Daenerys", aesthetics = "fill") {
	scale_colour_got_d(..., alpha = alpha, begin = begin, end = end, direction = direction,
										 option = option, aesthetics = aesthetics)
}
