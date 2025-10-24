# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Document parameters, class attributes, return types, and variables inline"
HOMEPAGE="
	https://github.com/fastapi/annotated-doc/
	https://pypi.org/project/annotated-doc/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	<dev-python/uv-build-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/uv-build-0.9.1[${PYTHON_USEDEP}]
	test? (
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
