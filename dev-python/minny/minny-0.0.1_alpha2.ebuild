# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Package and project manager for MicroPython and CircuitPython"
HOMEPAGE="
	https://github.com/aivarannamaa/minny
	https://pypi.org/project/minny/
"

# Upstream has incomplete sdist on PyPI and missing tags in git
#  reported upstream; temporary workaround
MY_COMMIT=fa7bcdfc54a846c604d1600db79a05e636de6667
SRC_URI="
	https://github.com/aivarannamaa/minny/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

PATCHES=(
	"${FILESDIR}/fix-metadata.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"

# Tests broken
EPYTEST_DESELECT=(
	tests/test_circup_install.py::test_with_deps_install
	tests/test_circup_install.py::test_no_deps_install
	tests/test_deploy.py::test_basic_deploy
	tests/test_sync.py::test_sync_command
	tests/test_circup_build.py::test_single_build
	tests/test_circup_build.py::test_build_matches_bundle
)
distutils_enable_tests pytest
