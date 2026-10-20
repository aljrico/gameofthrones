# gameofthrones 1.0.3

* Fixes HTML5 validation of the Rd files (the reason for the 2022 CRAN archival).
* `got()` caches each palette's colour ramp, so repeated calls are much faster.
* Drops the unused `gridExtra` and `MASS` dependencies.

# gameofthrones 1.0.2

* Now you can access all palettes names by `names(got_palettes)`.

# gameofthrones 1.0.1

* New default palette is _Daenerys_.
