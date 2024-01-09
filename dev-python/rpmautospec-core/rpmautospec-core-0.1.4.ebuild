# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Core functionality used by rpmautospec"
HOMEPAGE="
	https://github.com/fedora-infra/rpmautospec-core/
	https://pypi.org/project/rpmautospec-core/
"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

distutils_enable_tests pytest

python_test() {
	# Disable pytest-cov
	epytest -o addopts=
}
