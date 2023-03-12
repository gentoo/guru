# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit bash-completion-r1 distutils-r1 optfeature

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-2.5 CC-BY-SA-4.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-text/ghostscript-gpl-9.50
	>=app-text/pdfminer-20201018[${PYTHON_USEDEP}]
	>=app-text/tesseract-4.1.1[jpeg,tiff,png,webp]
	>=dev-python/coloredlogs-14.0[${PYTHON_USEDEP}]
	>=dev-python/deprecation-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20[${PYTHON_USEDEP}]
	>dev-python/pikepdf-5.0.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-8.2.0[lcms,${PYTHON_USEDEP}]
	>=dev-python/pluggy-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/reportlab-3.5.66[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4[${PYTHON_USEDEP}]
	>=media-gfx/img2pdf-0.3.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		>=app-text/unpaper-6.1
		dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		>=dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
		>=media-libs/jbig2enc-0.29
		>=media-gfx/pngquant-2.5
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-issues \
	dev-python/sphinx-rtd-theme

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

src_prepare() {
	distutils-r1_src_prepare
	sed -e "/-n auto/d" -i pyproject.toml || die
}

src_install() {
	distutils-r1_src_install
	newbashcomp misc/completion/ocrmypdf.bash "${PN,,}"

	insinto /usr/share/fish/vendor_completions.d
	doins misc/completion/ocrmypdf.fish
}

pkg_postinst() {
	optfeature "JBIG2 optimization support" media-libs/jbig2enc
	optfeature "image cleaning support" app-text/unpaper
	optfeature "PNG optimization support" media-gfx/pngquant
}
