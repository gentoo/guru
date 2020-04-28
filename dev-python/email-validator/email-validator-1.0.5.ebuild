# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

# Tests are not in release tarballs
MYPN="python-${PN}"
MYP="${MYPN}-${PV}"

DESCRIPTION="A robust email syntax and deliverability validation library"
HOMEPAGE="https://github.com/JoshData/python-email-validator"
SRC_URI="https://github.com/JoshData/${MYPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"

S="${WORKDIR}/${MYP}"

RDEPEND="
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
"
