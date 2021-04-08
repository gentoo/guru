# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION="Common S3 Generics not Provided by Base R Methods Related to Model Fitting"
KEYWORDS="~amd64"
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
HOMEPAGE="https://cran.r-project.org/package=generics"
LICENSE="MIT"
DEPEND=">=dev-lang/R-3.1"
RDEPEND="${DEPEND-}"
