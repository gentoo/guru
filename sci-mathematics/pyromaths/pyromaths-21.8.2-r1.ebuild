# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DEPEND="
	dev-python/sphinx-argparse
"
DOCS_DIR="Doc/source"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 docs

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
IUSE="doc"

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
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/setuptools.patch"
)

distutils_enable_tests pytest
