# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Proton Technologies API wrapper"
HOMEPAGE="https://github.com/ProtonVPN/python-proton-core/"
SRC_URI="https://github.com/ProtonVPN/python-proton-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-${P}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-python/pyotp[${PYTHON_USEDEP}] )"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-gnupg[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	sed -i "/--cov/d" setup.cfg || die
}

python_test() {
	# The following tests need network

	EPYTEST_DESELECT=(
		"tests/test_alternativerouting.py::TestAlternativeRouting::test_alternative_routing_works_on_prod"
		"tests/test_autotransport.py::TestAuto::test_auto_works_on_prod"
		"tests/test_protonsso.py::TestProtonSSO::test_broken_data"
		"tests/test_protonsso.py::TestProtonSSO::test_broken_index"
		"tests/test_protonsso.py::TestProtonSSO::test_sessions"
		"tests/test_session.py::TestSession::test_ping"
		"tests/test_tlsverification.py::TestTLSValidation::test_bad_pinning_fingerprint_changed"
		"tests/test_tlsverification.py::TestTLSValidation::test_bad_pinning_url_changed"
		"tests/test_tlsverification.py::TestTLSValidation::test_successful"
		"tests/test_tlsverification.py::TestTLSValidation::test_without_pinning"
	)

	XDG_RUNTIME_DIR="${T}/python_test" epytest
}
