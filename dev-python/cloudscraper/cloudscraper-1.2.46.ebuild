# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="A Python module to bypass Cloudflare's anti-bot page"
HOMEPAGE="https://github.com/venomous/cloudscraper"
SRC_URI="https://github.com/VeNoMouS/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-python/js2py[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)"
RDEPEND="
	>=dev-python/requests-2.9.2[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-0.9.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
