# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Translate Spreadsheet Cell Ranges to Rows and Columns'
LICENSE='MIT'
HOMEPAGE="
	https://github.com/rsheets/cellranger
	https://cran.r-project.org/package=cellranger
"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.0.0
	dev-R/rematch
	dev-R/tibble
"
RDEPEND="${DEPEND}"
