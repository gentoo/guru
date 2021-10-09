# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_8 )
inherit distutils-r1

EGIT_REPO_URI="https://github.com/fakefred/${PN}"

case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
		# pyinquirer's latest version is outdated, so memethesis depends
		# on a live ebuild for pyinquirer at the moment
		KEYWORDS="~amd64"
esac

DESCRIPTION="Create memes from the terminal"
HOMEPAGE="https://github.com/fakefred/memethesis-cli"
LICENSE="GPL-3"
SLOT="0"

PATCHES=( "${FILESDIR}/prompt.patch" )

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/pillow[truetype,${PYTHON_USEDEP}]
		>dev-python/pyinquirer-1.0.3[${PYTHON_USEDEP}]
		dev-python/colored[${PYTHON_USEDEP}]
		dev-python/ascim[${PYTHON_USEDEP}]')
	>=media-gfx/imagemagick-7"
BDEPEND="${RDEPEND}"
