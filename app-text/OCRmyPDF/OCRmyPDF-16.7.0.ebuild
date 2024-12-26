# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 optfeature pypi shell-completion

DESCRIPTION="OCRmyPDF adds an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"

LICENSE="CC-BY-SA-2.5 CC-BY-SA-4.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-text/ghostscript-gpl-10.01.2
	>=app-text/pdfminer-20220319[${PYTHON_USEDEP}]
	>=app-text/tesseract-4.1.1[jpeg,tiff,png,webp]
	>=dev-python/deprecation-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20[${PYTHON_USEDEP}]
	>=dev-python/pikepdf-8.10.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.1[lcms,${PYTHON_USEDEP}]
	>=dev-python/pluggy-1.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0[${PYTHON_USEDEP}]
	>=media-gfx/img2pdf-0.5[${PYTHON_USEDEP}]
"
# TODO: package PyMuPDF for tests
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		app-text/tessdata_fast[l10n_de,l10n_en]
		>=app-text/unpaper-6.1
		>=dev-python/hypothesis-6.36.0[${PYTHON_USEDEP}]
		>=dev-python/python-xmp-toolkit-2.0.1[${PYTHON_USEDEP}]
		>=dev-python/reportlab-3.6.8[${PYTHON_USEDEP}]
		>=media-gfx/pngquant-2.5
		>=media-libs/jbig2enc-0.29
	)
"

EPYTEST_XDIST="yes"
EPYTEST_IGNORE=(
	# Useless test
	tests/test_completion.py
)
EPYTEST_DESELECT=(
	# Fails if Tesseract was compiled with Clang
	tests/test_rotation.py::test_rotate_deskew_ocr_timeout

	# XFAIL reason should be a string, not a tuple
	tests/test_metadata.py::test_malformed_docinfo
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-issues \
	dev-python/sphinx-rtd-theme

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	epytest -o addopts=
}

src_install() {
	distutils-r1_src_install

	newbashcomp misc/completion/ocrmypdf.bash ocrmypdf
	dofishcomp misc/completion/ocrmypdf.fish
}

pkg_postinst() {
	optfeature "image cleaning support" app-text/unpaper
	optfeature "JBIG2 optimization support" media-libs/jbig2enc
	optfeature "PNG optimization support" media-gfx/pngquant

	# TODO: package pi-heif
	#optfeature "HEIF image format support" dev-python/pi-heif
}
