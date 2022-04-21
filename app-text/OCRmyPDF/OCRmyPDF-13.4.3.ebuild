# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7,8,9,10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit bash-completion-r1 distutils-r1

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"
SRC_URI="https://github.com/ocrmypdf/OCRmyPDF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

# This uses *a lot* of RAM, I have 32gb and these tests tried to use it all
RESTRICT="test"
IUSE="jbig2enc"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/tesseract
	app-text/unpaper
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	>dev-python/pdfminer-six-20200720[${PYTHON_USEDEP}]
	dev-python/pikepdf[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-gfx/img2pdf[${PYTHON_USEDEP}]
	media-gfx/pngquant
	media-libs/leptonica
	virtual/python-cffi[${PYTHON_USEDEP}]
	jbig2enc? ( media-libs/jbig2enc )
"
DEPEND="
	test? (
		dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		~dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

src_install() {
	distutils-r1_src_install
	newbashcomp misc/completion/ocrmypdf.bash "${PN,,}"
	insinto /usr/share/fish/vendor_completions.d
	doins misc/completion/ocrmypdf.fish
}
