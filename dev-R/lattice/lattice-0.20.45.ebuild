# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages optfeature

DESCRIPTION='Trellis Graphics for R'
HOMEPAGE="http://lattice.r-forge.r-project.org/index.php"
KEYWORDS="~amd64"
SRC_URI="mirror://cran/src/contrib/"${PN}"_"$(ver_rs 2 '-')".tar.gz -> "${P}".tar.gz"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.0.0
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	optfeature "immer in the MASS package for data from the same experiment (expressed as total yield for 3 blocks) for a subset of varieties" dev-R/MASS
}
