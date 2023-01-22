# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Create maths exercises in LaTeX and PDF format"

HOMEPAGE="
	https://www.pyromaths.org
	https://pypi.org/project/pyromaths
	https://framagit.org/pyromaths/pyromaths
"
SRC_URI="https://framagit.org/${PN}/${PN}/-/archive/version-${PV}/${PN}-version-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-version-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND="
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-texlive/texlive-pstricks
	dev-texlive/texlive-basic
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-fontsrecommended
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-mathscience
"
BDEPEND="dev-python/jinja2-cli"
DEPEND="${RDEPEND} ${BDEPEND}"

PATCHES=(
	"${FILESDIR}/setuptools.patch"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs
