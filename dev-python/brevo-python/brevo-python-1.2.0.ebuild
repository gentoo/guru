# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Official SDK for the Brevo API"
HOMEPAGE="
	https://brevo.com/
	https://pypi.org/project/brevo-python/
	https://github.com/getbrevo/brevo-python/"
SRC_URI="https://github.com/getbrevo/brevo-python/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

PATCHES=( "${FILESDIR}/1.2.0-dont-install-test.patch" )

LICENSE="MIT"

SLOT="1"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.23[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${RDEPEND} )"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	# tries to load nonexistent module
	test/test_configuration.py )
distutils_enable_tests pytest
