# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 #pypi

DESCRIPTION="Brings async, event-driven capabilities to Django"
HOMEPAGE="
	https://channels.readthedocs.io/
	https://github.com/django/channels/
	https://pypi.org/project/channels/
"
# no tests in sdist
SRC_URI="
	https://github.com/django/channels/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/asgiref-4[${PYTHON_USEDEP}]
	>=dev-python/asgiref-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/django-4.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/async-timeout[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# avoid daphne as it requires autobahn
	tests/sample_project/tests/test_selenium.py
	tests/security/test_websocket.py
	tests/test_database.py
	tests/test_generic_http.py
	tests/test_generic_websocket.py
	tests/test_http.py
	tests/test_testing.py
)

EPYTEST_PLUGINS=( pytest-django pytest-asyncio )
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/channels-4.3.2-fix-install.patch
)

python_prepare_all() {
	# avoid daphne as it requires autobahn
	sed -e '/"daphne"/d' -i tests/sample_project/config/settings.py || die

	distutils-r1_python_prepare_all
}
