
<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/houses.png" ></center>

[![cran version](http://www.r-pkg.org/badges/version/gameofthrones)](https://cran.r-project.org/package=gameofthrones)
[![rstudio mirror per-month downloads](http://cranlogs.r-pkg.org/badges/gameofthrones)](https://github.com/metacran/cranlogs.app)
[![rstudio mirror total downloads](http://cranlogs.r-pkg.org/badges/grand-total/gameofthrones?color=yellowgreen)](https://github.com/metacran/cranlogs.app)


This package provides a round of palettes inspired by the *Game of
Thrones* TV show.

At its first version, it simply contains the palettes of some of the
houses of Westeros. They have been chosen manually, taking into account
its consistency with all the existing branding of the franchise, but its
suitability for data visualisation.

> Information visualization is just a language with everything to be
> discovered.

A colour palette should not only be beautiful, but suitable for portraying and highlighting data. The colours of this palette has been chose trying to to find this balance between suitability for plotting
and relatability to the world of *A Song of Ice and Fire*.



Installation
------------

Just copy and execute this bunch of code and you’ll have the last
version of the package installed:

``` r
devtools::install_github("aljrico/gameofthrones")
```

And you can now use it:

``` r
library(gameofthrones)
```

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-11-1.png" ></center>


Usage
-----

The default colour scale of the package is the one of the house
*Targaryen*. If you prefer to choose another one, you’ll need to specify
which house you want the palette from.

Let’s say that you want a palette made from the house **Targaryen**.

``` r
pal <- got(250, option = "Targaryen")
image(volcano, col = pal)
```
<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-3-1.png" ></center>

Or that you want _burn_ some plots down using *wildfire*.

``` r
pal <- got(250, option = "Wildfire")
image(volcano, col = pal)
```

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-4-1.png" ></center>


### ggplot2

Of course, this package has specific functions to behave seamlessly with
the best data visiualisation library available. The package contains
colour scale functions for **ggplot2** plots: `scale_color_got()` and
`scale_fill_got()`.

Here is a made up example using the colours from the house of
**Martell**,

``` r
library(ggplot2)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() + 
    coord_fixed() +
  scale_fill_got(option = "Martell") + 
    theme_bw()
```
<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-5-1.png" ></center>

and **Baratheon**

``` r
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() + 
    coord_fixed() +
  scale_fill_got(option = "Baratheon") + 
    theme_bw()
```

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-6-1.png" ></center>


You can also use it to create this cloropeth of the U.S Unemployment:

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-7-1.png" ></center>

But what if you want discrete scales? These functions also can be used
for discrete scales with the argument `discrete = TRUE`. This argument,
when TRUE, sets a finite number of sufficiently spaced colours within
the selected palette to plot your data. You can also bypass it by calling the function with a `_d()` at the end. So `scale_fill_got(discrete = TRUE)` becomes `scale_fill_got_d()`. Much easier, isn't it?

``` r
library(gridExtra)

gg1 <- ggplot(diamonds, aes(factor(color), fill=factor(cut))) +  
    geom_bar(colour = "black") +
  scale_fill_got(discrete = TRUE, option = "Margaery") +
    ggtitle("Lady Margaery") +
    theme_minimal()

gg2 <- ggplot(diamonds, aes(factor(color), fill=factor(cut))) +  
    geom_bar(colour = "black") +
  scale_fill_got_d(option = "Daenerys", direction = - 1) +
    ggtitle("Daenerys Stormborn") +
    theme_minimal()

grid.arrange(gg1,gg2)
```

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-8-1.png" ></center>

Note that you can also play with the direction of the colour map. Either
the default `direction = 1` or the opposite `direction = -1`.

See how diferently you can highlight the density distribution of restaurans in southern France.

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-9-1.png" ></center>


Just make sure you try all the options.

``` r
gg1 <- ggplot(diamonds, aes(carat, fill = cut)) +
  geom_density(position = "stack") +
    scale_fill_got(discrete = TRUE, option = "Stark2")

gg2 <- ggplot(mpg, aes(class)) +
    geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE), colour = "black") +
 coord_flip() +
    scale_fill_got(discrete = TRUE, option = "Daenerys") +
 theme(legend.position = "top") +
    ylab("") +
    xlab("Class")

grid.arrange(gg1,gg2)
```

<center><img src="https://raw.githubusercontent.com/aljrico/gameofthrones/master/readme_raw_files/figure-markdown_github/unnamed-chunk-10-1.png" ></center>

