# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Seamless R and C++ Integration'
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-2+'
HOMEPAGE="
	http://www.rcpp.org
	http://dirk.eddelbuettel.com/code/rcpp.html
	https://github.com/RcppCore/Rcpp
	https://cran.r-project.org/package=Rcpp
"
IUSE="${IUSE-}"
KEYWORDS="~amd64"
