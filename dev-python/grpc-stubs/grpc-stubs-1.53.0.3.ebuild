# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1

DESCRIPTION="gRPC typing stubs for Python"
HOMEPAGE="
	https://pypi.org/project/grpc-stubs/
	https://github.com/shabbyrobe/grpc-stubs/
"

SRC_URI="https://github.com/shabbyrobe/grpc-stubs/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-python/types-protobuf[${PYTHON_USEDEP}]"
BDEPEND="test? (
				dev-python/pytest-mypy-plugins[${PYTHON_USEDEP}]
				${RDEPEND}
			   )"

distutils_enable_tests pytest

PATCHES="${FILESDIR}/"${P}-die-on-missing-import.patch

python_test() {
	# Gentoo's PEP 517 mode runs tests in a venv-like environment.
	# Pytest-mypy-plugins checks the PATH for mypy, we provide a venv-aware
	# variant.
	printf "#!/bin/bash\n $(which python) -m mypy \$@" > \
		 "${BUILD_DIR}"/install/usr/bin/mypy || die
	chmod +x "${BUILD_DIR}"/install/usr/bin/mypy || die
	epytest --mypy-ini-file=setup.cfg
	rm "${BUILD_DIR}"/install/usr/bin/mypy || die
}
