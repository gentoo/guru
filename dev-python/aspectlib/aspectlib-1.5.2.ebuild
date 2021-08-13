# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="An aspect-oriented programming, monkey-patch and decorators library"
HOMEPAGE="
	https://github.com/ionelmc/python-aspectlib
	https://pypi.org/project/python-aspectlib
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/process-tests[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
)"

S="${WORKDIR}/python-${P}"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

python_test() {
	local epytest_args=(
		# fails because error message text is slightly different
		--deselect tests/test_aspectlib_test.py::test_story_empty_play_proxy_class
		--deselect tests/test_aspectlib_test.py::test_story_half_play_proxy_class
		# Test fails with tornado>=6
		# https://github.com/ionelmc/python-aspectlib/issues/15
		--deselect tests/test_integrations_py3.py::test_decorate_tornado_coroutine
	)
	epytest "${epytest_args[@]}"
}
