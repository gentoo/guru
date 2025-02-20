# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Twilio SendGrid library for Python"
HOMEPAGE="https://github.com/sendgrid/sendgrid-python/ https://pypi.org/project/sendgrid/"
SRC_URI="https://github.com/sendgrid/sendgrid-python/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-python-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS="README.rst"

RDEPEND="
	>=dev-python/flask-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-http-client-3.3.5[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-4.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/starkbank-ecdsa-2.2.0[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
"

EPYTEST_IGNORE=(
	# requires internet access
	live_test.py
)
EPYTEST_DESELECT=(
	# requires internet access
	test/integ/test_sendgrid.py
)

distutils_enable_tests pytest

src_prepare() {
	sed -i 's/"test"/"test", "test.*"/' setup.py || die
	distutils-r1_src_prepare
}
