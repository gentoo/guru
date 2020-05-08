# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Simple Data Frames'
SRC_URI="http://cran.r-project.org/src/contrib/tibble_3.0.1.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://tibble.tidyverse.org
	https://github.com/tidyverse/tibble
	https://cran.r-project.org/package=tibble
"
IUSE="${IUSE-}"
DEPEND="
	>=dev-lang/R-3.1.0
	dev-R/cli
	>=dev-R/crayon-1.3.4
	>=dev-R/lifecycle-0.2.0
	>=dev-R/ellipsis-0.2.0
	>=dev-R/fansi-0.4.0
	dev-R/magrittr
	>=dev-R/pillar-1.4.3
	dev-R/pkgconfig
	>=dev-R/rlang-0.4.3
	>=dev-R/vctrs-0.2.4
"
RDEPEND="${DEPEND-}"
