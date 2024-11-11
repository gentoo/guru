# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 linux-info

DESCRIPTION="Helper tool for developing and building postmarketOS"
HOMEPAGE="https://postmarketos.org/"
SRC_URI="https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"

# According to upstream README either x86, amd64 or arm64 are required. I
# wrote down all other arches because if I just did -* without adding x86 and
# arm64 keywords it would seem like the package only works on amd64, but I can't
# keyword x86 and arm64 because I can't test these.
KEYWORDS="-alpha ~amd64 -arm -hppa -ppc -ppc64 -riscv -sparc"
# Tests are disabled because they require the pmaports repository (containing
# postmarketOS APKBUILDs) to be cloned at runtime.
RESTRICT="mirror"

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	dev-vcs/git
	sys-fs/multipath-tools
"

distutils_enable_tests pytest

pkg_pretend() {
	if kernel_is -lt 3 17 0; then
		eerror "pmbootstrap requires Linux 3.17 or greater."
		die
	fi
}

# Without this, emerge errors with an "EPYTHON not set" error.
pkg_setup() {
	python-single-r1_pkg_setup
}

python_test() {
	local -x EPYTEST_DESELECT=()

	# test_pkgrepo.py is disabled because it requires the pmaports repository (containing
	# postmarketOS APKBUILDs) to be cloned at runtime.
	EPYTEST_DESELECT+=(
		"pmb/core/test_pkgrepo.py"
	)

	distutils-r1_python_test
}
