# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="Library of web-related functions"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/w3lib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest

python_test(){
	# https://github.com/scrapy/w3lib/issues/164
	py.test -k "not test_add_or_replace_parameter" || die
}
