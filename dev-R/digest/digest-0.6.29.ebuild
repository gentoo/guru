# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Create Compact Hash Digests of R Objects'
HOMEPAGE="
	http://dirk.eddelbuettel.com/code/digest.html
	https://github.com/eddelbuettel/digest
"
LICENSE='GPL-2+'
KEYWORDS="~amd64"
RDEPEND=">=dev-lang/R-3.3.0"
DEPEND="${RDEPEND}"

SUGGESTES_PACKAGES="
	dev-R/tinytest
	dev-R/simplermarkdown
"
