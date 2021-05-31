# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Select from a Set of Strings'
LICENSE='GPL-3'
HOMEPAGE="
	https://tidyselect.r-lib.org
	https://github.com/r-lib/tidyselect
	https://cran.r-project.org/package=tidyselect
"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.2
	dev-R/ellipsis
	>=dev-R/glue-1.3.0
	>=dev-R/purrr-0.3.2
	>=dev-R/rlang-0.4.6
	>=dev-R/vctrs-0.3.0
"
RDEPEND="${DEPEND}"
