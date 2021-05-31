# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Interpreted String Literals'
HOMEPAGE="
	https://glue.tidyverse.org
	https://github.com/tidyverse/glue
	https://cran.r-project.org/package=glue
"
LICENSE='MIT'
KEYWORDS="~amd64"
DEPEND=">=dev-lang/R-3.2"
RDEPEND="${DEPEND}"
