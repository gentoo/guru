# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13})
inherit distutils-r1 pypi

DESCRIPTION="Socket.IO integration for Flask applications."
HOMEPAGE="https://flask-socketio.readthedocs.io https://github.com/miguelgrinberg/flask-socketio"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/python-socketio[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	test? (
		dev-python/redis[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
