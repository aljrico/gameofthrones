
<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/hogwarts-houses.png"></center>


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


<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/show_scales2-1.png" ></center>



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


Usage
-----

The default colour scale of the package is the one of the house *Hufflepuff*. If you prefer to choose another one, you'll need to specify which house you want the palette from.

Let's say that you want a palette made from the house **Gryffindor**.


```r
pal <- hp(25, house = "Gryffindor")
image(volcano, col = pal)
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-3-1.png" ></center>

Or a bit more like me, you prefer to be a **Ravenclaw**.


```r
pal <- hp(25, house = "Ravenclaw")
image(volcano, col = pal)
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-4-1.png" ></center>

Or put them all together


```r
pal_gryff <- hp(25, house = "Gryffindor")
pal_rav   <- hp(25, house = "Ravenclaw")
pal_huff  <- hp(25, house = "Hufflepuff")
pal_sly   <- hp(25, house = "Slytherin")

par(mfrow = c(2,2))
image(volcano, col = pal_gryff)
image(volcano, col = pal_rav)
image(volcano, col = pal_huff)
image(volcano, col = pal_sly)
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-5-1.png" ></center>

### ggplot2

Of course, this package has specific functions to behave seamlessly with the best data visiualisation library available. 
The package contains colour scale functions for **ggplot2** plots: `scale_color_hp()` and `scale_fill_hp()`.


Here is a made up example using the colours from the house of **Hufflepuff**,


```r
library(ggplot2)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() + 
	coord_fixed() +
  scale_fill_hp(house = "hufflepuff") + 
	theme_bw()
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-6-1.png" ></center>

and **Ravenclaw**


```r
library(ggplot2)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() + 
	coord_fixed() +
  scale_fill_hp(house = "ravenclaw") + 
	theme_bw()
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-7-1.png" ></center>


or more made-up heatmaps

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-8-1.png" ></center>


Using the same function we can also plot these cloropleth maps of U.S. unemployment:

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/ggplot2-1.png" ></center>

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/ggplot2-2.png" ></center>



But what if you want discrete scales? These functions also can be used for discrete scales with the argument `discrete = TRUE`. This argument, when TRUE, sets a finite number of sufficiently spaced colours within the selected palette to plot your data.


```r
library("ggplot2")
ggplot(mtcars, aes(factor(cyl), fill=factor(vs))) +  
	geom_bar() +
  scale_fill_hp(discrete = TRUE, house = "Ravenclaw")
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-9-1.png" ></center>


```r
ggplot(mpg, aes(class)) +
	geom_bar(aes(fill = drv), position = position_stack(reverse = TRUE)) +
 coord_flip() +
	scale_fill_hp(discrete = TRUE, house = "Gryffindor") +
 theme(legend.position = "top") +
	ylab("") +
	xlab("Class")
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-10-1.png" ></center>




```r
x <- y <- seq(-8*pi, 8*pi, len = 40)
r <- sqrt(outer(x^2, y^2, "+"))
filled.contour(cos(r^2)*exp(-r/(2*pi)), 
               axes=FALSE,
               color.palette=hp,
               asp=1)
```

<center><img src="https://raw.githubusercontent.com/aljrico/aljrico.github.io/master/_posts/images/unnamed-chunk-11-1.png" ></center>
