# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit git-r3 meson python-any-r1 virtualx xdg

DESCRIPTION="A lightweight compositor for X11 (previously a compton fork)"
HOMEPAGE="https://github.com/jonaburg/picom"
if [[ ${PV} == *9999 ]]; then
		EGIT_REPO_URI="https://github.com/jonaburg/picom.git"
else
		COMMIT="e3c19cd7d1108d114552267f302548c113278d45"
		VERSION_REV="e3c19cd"
		SRC_URI="https://github.com/jonaburg/picom/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${COMMIT}"
		KEYWORDS="~amd64"
fi

LICENSE="MPL-2.0 MIT"
SLOT="0"
IUSE="+config-file dbus +doc +drm opengl pcre test"

REQUIRED_USE="test? ( dbus )" # avoid "DBus support not compiled in!"
RESTRICT="test" # but tests require dbus_next

RDEPEND="dev-libs/libev
	dev-libs/uthash
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/pixman
	x11-libs/xcb-util-image
	x11-libs/xcb-util-renderutil
	config-file? (
		dev-libs/libconfig:=
	)
	dbus? ( sys-apps/dbus )
	drm? ( x11-libs/libdrm )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre )
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
BDEPEND="virtual/pkgconfig
	doc? ( app-text/asciidoc )
	test? ( $(python_gen_any_dep 'dev-python/xcffib[${PYTHON_USEDEP}]') )
"

DOCS=( README.md picom.sample.conf )

python_check_deps() {
	python_has_version -b "dev-python/xcffib[${PYTHON_USEDEP}]"
}

src_configure() {
	local emesonargs=(
		$(meson_use config-file config_file)
		$(meson_use dbus)
		$(meson_use doc with_docs)
		$(meson_use opengl)
		$(meson_use pcre regex)
	)

	meson_src_configure
}

src_test() {
	virtx "${S}/tests/run_tests.sh" "${BUILD_DIR}/src/${PN}"
}
