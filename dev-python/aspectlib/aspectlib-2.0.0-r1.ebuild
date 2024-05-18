# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Aspect-oriented programming, monkey-patch and decorators library"
HOMEPAGE="
	https://github.com/ionelmc/python-aspectlib
	https://pypi.org/project/aspectlib/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-py3doc-enhanced-theme

EEPYTEST_DESELECT=(
	# fails because error message text is slightly different
	tests/test_aspectlib_test.py::test_story_empty_play_proxy_class
	tests/test_aspectlib_test.py::test_story_half_play_proxy_class
)
