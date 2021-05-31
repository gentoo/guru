# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A Toolbox for Manipulating and Assessing colors and palettes'
SRC_URI="mirror://cran/src/contrib/colorspace_2.0-1.tar.gz"
KEYWORDS="~amd64"
LICENSE='BSD'

DEPEND=">=dev-lang/R-3.0.0"
RDEPEND="${DEPEND}"
