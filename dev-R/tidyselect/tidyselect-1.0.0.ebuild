# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Select from a Set of Strings'
SRC_URI="http://cran.r-project.org/src/contrib/tidyselect_1.0.0.tar.gz"
LICENSE='GPL-3'
HOMEPAGE="
	https://tidyselect.r-lib.org
	https://github.com/r-lib/tidyselect
	https://cran.r-project.org/package=tidyselect
"
IUSE="${IUSE-}"
DEPEND="
	>=dev-lang/R-3.2
	dev-R/ellipsis
	>=dev-R/glue-1.3.0
	>=dev-R/purrr-0.3.2
	>=dev-R/rlang-0.4.3
	>=dev-R/vctrs-0.2.2
"
RDEPEND="${DEPEND-}"
