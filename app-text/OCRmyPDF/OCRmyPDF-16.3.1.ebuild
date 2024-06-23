# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 optfeature shell-completion

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"
SRC_URI="https://github.com/ocrmypdf/ocrmypdf/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-2.5 CC-BY-SA-4.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	>=app-text/ghostscript-gpl-10.01.2
	>=app-text/pdfminer-20220319[${PYTHON_USEDEP}]
	>=app-text/tesseract-4.1.1[jpeg,tiff,png,webp]
	>=dev-python/coloredlogs-14.0[${PYTHON_USEDEP}]
	>=dev-python/deprecation-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20[${PYTHON_USEDEP}]
	>dev-python/pikepdf-5.0.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.1[lcms,${PYTHON_USEDEP}]
	>=dev-python/pluggy-1.0[${PYTHON_USEDEP}]
	>=dev-python/reportlab-3.5.66[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4[${PYTHON_USEDEP}]
	>=media-gfx/img2pdf-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		app-text/tessdata_fast[l10n_de,l10n_en]
		>=app-text/unpaper-6.1
		>=dev-python/hypothesis-6.36.0[${PYTHON_USEDEP}]
		dev-python/pytest-helpers-namespace[${PYTHON_USEDEP}]
		>=dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
		media-libs/exempi:2
		>=media-libs/jbig2enc-0.29
		media-libs/libxmp
		>=media-gfx/pngquant-2.5
		>=dev-python/pytest-6.2.5[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-xdist-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/reportlab-3.6.8[${PYTHON_USEDEP}]
		>=dev-python/coverage-6.2[${PYTHON_USEDEP}]
		dev-python/humanfriendly[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# useless test
	tests/test_completion.py
)

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

	dofishcomp misc/completion/ocrmypdf.fish
}

pkg_postinst() {
	optfeature "JBIG2 optimization support" media-libs/jbig2enc
	optfeature "image cleaning support" app-text/unpaper
	optfeature "PNG optimization support" media-gfx/pngquant
}
