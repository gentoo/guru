# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Translate Spreadsheet Cell Ranges to Rows and Columns'
SRC_URI="http://cran.r-project.org/src/contrib/cellranger_1.1.0.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://github.com/rsheets/cellranger
	https://cran.r-project.org/package=cellranger
"
IUSE="${IUSE-}"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.0.0
	dev-R/rematch
	dev-R/tibble
"
RDEPEND="${DEPEND-}"
