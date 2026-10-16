# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

DESCRIPTION="A rough port of Node.js's EventEmitter to Python with a few tricks of its own"
HOMEPAGE="https://github.com/jfhbrook/pyee"
SRC_URI="https://github.com/jfhbrook/pyee/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-asyncio pytest-trio pytest-twisted )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "trio support" dev-python/trio
	optfeature "twisted support" dev-python/twisted
}
