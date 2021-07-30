# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} )

#DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

# This package uses rc1 without the underscore which is not supported by
# portage
VNAME="4.0.0rc1"
S="${WORKDIR}/${PN}-${VNAME}"

DESCRIPTION="Free Google Translate API for Python. Translates totally free of charge."
HOMEPAGE="https://pypi.org/project/googletrans"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${PN}-${VNAME}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
