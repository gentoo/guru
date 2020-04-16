# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit bash-completion-r1 distutils-r1

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/jbarlow83/OCRmyPDF"
MY_GITHUB_AUTHOR="jbarlow83"
SRC_URI="https://github.com/${MY_GITHUB_AUTHOR}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# This uses *a lot* of RAM, I have 32gb and these tests tried to use it all
RESTRICT="test"
IUSE="jbig2enc"

DEPEND="test? (
	dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
	~dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
)"

RDEPEND="
	app-text/ghostscript-gpl
	app-text/tesseract
	app-text/unpaper
	<=dev-python/pdfminer-six-20200402[${PYTHON_USEDEP}]
	>=dev-python/pdfminer-six-20181108[${PYTHON_USEDEP}]
	dev-python/pikepdf[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-gfx/img2pdf
	media-gfx/pngquant
	media-libs/leptonica
	virtual/python-cffi[${PYTHON_USEDEP}]
	jbig2enc? ( media-libs/jbig2enc )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

python_prepare_all() {
	# do not depend on deprecated dep
	sed -i -e '/pytest-runner/d' setup.py || die

	distutils-r1_python_prepare_all
}

src_install() {
	distutils-r1_src_install

	newbashcomp "${S}"/misc/completion/ocrmypdf.bash "${PN,,}"

	insinto /usr/share/fish/vendor_completions.d
	doins "${S}"/misc/completion/ocrmypdf.fish
}
