# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Create Compact Hash Digests of R Objects'
HOMEPAGE="
	http://dirk.eddelbuettel.com/code/digest.html
	https://github.com/eddelbuettel/digest
"
SRC_URI="http://cran.r-project.org/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-2+'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
RDEPEND=">=dev-lang/R-3.1.0"
DEPEND="${RDEPEND}"
