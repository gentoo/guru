# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit bash-completion-r1 distutils-r1 optfeature

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"
SRC_URI="https://github.com/ocrmypdf/OCRmyPDF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # Exhausts RAM

RDEPEND="
	>=app-text/ghostscript-gpl-9.50
	>=app-text/tesseract-4.1.1
	app-text/unpaper
	dev-python/cffi[${PYTHON_USEDEP}]
	>=dev-python/coloredlogs-15.0.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-20[${PYTHON_USEDEP}]
	>dev-python/pdfminer-six-20200720[${PYTHON_USEDEP}]
	>dev-python/pikepdf-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-8.2.0[${PYTHON_USEDEP}]
	>=dev-python/pluggy-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/reportlab-3.5.66[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4[${PYTHON_USEDEP}]
	>=media-gfx/img2pdf-0.3.0[${PYTHON_USEDEP}]
	media-gfx/pngquant
	media-libs/leptonica
	virtual/python-cffi[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		~dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

src_install() {
	distutils-r1_src_install
	newbashcomp misc/completion/ocrmypdf.bash "${PN,,}"
	insinto /usr/share/fish/vendor_completions.d
	doins misc/completion/ocrmypdf.fish
}

pkg_postinst() {
	optfeature "JBIG2 support" media-libs/jbig2enc
}
