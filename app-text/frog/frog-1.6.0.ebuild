# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 gnome2-utils meson xdg

DESCRIPTION="Extract text from any image, video, QR Code and etc."
HOMEPAGE="https://github.com/TenderOwl/Frog"
SRC_URI="https://github.com/TenderOwl/Frog/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Frog-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libportal
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/gstreamer:1.0
	x11-libs/libnotify

	|| (
		app-text/tessdata_fast
		app-text/tessdata_best
		app-text/tessdata_legacy
	)

	$(python_gen_cond_dep '
		dev-python/gtts[${PYTHON_USEDEP}]
		dev-python/loguru[${PYTHON_USEDEP}]
		dev-python/posthog[${PYTHON_USEDEP}]
		dev-python/py-nanoid[${PYTHON_USEDEP}]
		dev-python/pytesseract[${PYTHON_USEDEP}]
		dev-python/pyzbar[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/glib:2
	dev-util/blueprint-compiler
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext
"

PATCHES=(
	"${FILESDIR}/${PN}-1.6.0-install-the-AppData-file-into-the-metainfo-directory.patch"
	"${FILESDIR}/${PN}-1.6.0-remove-the-AppData-file-validation-test.patch"
	"${FILESDIR}/${PN}-1.6.0-use-the-system-tessdata-directory.patch"
)

distutils_enable_tests import-check

python_test() {
	epytest --import-check frog
}

src_test() {
	meson_src_test
	distutils-r1_src_test
}

src_install() {
	meson_src_install

	python_fix_shebang "${ED}/usr/bin"
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
