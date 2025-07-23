EAPI=8

inherit meson

DESCRIPTION="X11 compatibility layer levaraging wlroots and Xwayland"
HOMEPAGE="https://wayback.freedesktop.org"

SRC_URI="https://gitlab.freedesktop.org/wayback/${PN}/-/archive/${PV}/${PN}-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

RDEPEND="
	>=gui-libs/wlroots-0.18.0
	>=x11-base/xwayland-24.1.8
"

DEPEND="
	${RDEPEND}
	>=dev-libs/wayland-1.20.0
	>=x11-libs/libxkbcommon-1.5.0:0=
"

BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	>=dev-build/meson-0.60.0
	virtual/pkgconfig
"

BDEPEND+="man? ( >=app-text/scdoc-1.9.3 )"

src_configure() {
	local emesonargs=(
		$(meson_feature man generate_manpages)
	)
	meson_src_configure
}
