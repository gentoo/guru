# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Create maths exercises in LaTeX and PDF format"

HOMEPAGE="
	https://pyromaths.frama.io/pyromaths-staticsite
	https://pypi.org/project/pyromaths
	https://framagit.org/pyromaths/pyromaths
"
SRC_URI="https://framagit.org/${PN}/${PN}/-/archive/version-${PV}/${PN}-version-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-version-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test doc"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-tex/latexmk
	dev-texlive/texlive-pstricks
	dev-texlive/texlive-basic
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-fontsrecommended
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-mathscience
"
BDEPEND="
	dev-python/jinja2-cli[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-argparse[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/setuptools.patch"
)

distutils_enable_tests pytest

python_compile() {
	distutils-r1_python_compile
	use doc && emake man -C Doc
}

python_install() {
	distutils-r1_python_install
	use doc && doman "${S}/Doc/build/man/pyromaths.1"
}
