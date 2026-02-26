# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Attempt to solve triangles given partial info about sides and angles"
HOMEPAGE="https://pypi.org/project/trianglesolver/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_test() {
	"${EPYTHON}" -c "import trianglesolver; trianglesolver.run_lots_of_tests()" \
		|| die "Tests failed with ${EPYTHON}"
}
