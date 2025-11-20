# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Material You color algorithms for python!"
HOMEPAGE="https://github.com/T-Dynamos/materialyoucolor-python"

LICENSE="MIT"
SLOT="0"

RESTRICT="network-sandbox"
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1

if [[ "${PV}" = *9999 ]]; then
	inherit git-r3
	BDEPEND="dev-vcs/git"
	EGIT_REPO_URI="https://github.com/T-Dynamos/materialyoucolor-python.git"
else
	SRC_URI="https://github.com/T-Dynamos/materialyoucolor-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-python-${PV}"
	KEYWORDS="~amd64 ~arm64"
fi

distutils_enable_tests import-check
