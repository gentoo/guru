# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 cmake

COMMIT="e30a64e97e0bf1c6bf68aa6f54a25c5995c2fdd2"

DESCRIPTION="Like neofetch but faster"
HOMEPAGE="https://github.com/LinusDierheimer/fastfetch"
SRC_URI="https://github.com/LinusDierheimer/fastfetch/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X gnome pci vulkan wayland xcb xfce xrandr"

# note - qa-vdb will always report errors because fastfetch loads the libs dynamically
RDEPEND="
	X? ( x11-libs/libX11 )
	gnome? (
		dev-libs/glib
		gnome-base/dconf
	)
	pci? ( sys-apps/pciutils )
	vulkan? ( media-libs/vulkan-loader )
	wayland? ( dev-libs/wayland )
	xcb? ( x11-libs/libxcb )
	xfce? ( xfce-base/xfconf )
	xrandr? ( x11-libs/libXrandr )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="xrandr? ( X )"

S="${WORKDIR}/${PN}-${COMMIT}"

# disable_check VAR lib
disable_check() {
	sed -i -e "
		/pkg_check_modules ($1 /d
		/message.*$2/d" CMakeLists.txt || die "Cannot disable $1"
}

src_configure() {
	disable_check RPM librpm

	use X || disable_check X11 x11
	use gnome || (disable_check GIO gio- && disable_check DCONF dconf)
	use pci || disable_check LIBPCI libpci
	use vulkan || disable_check VULKAN vulkan
	use wayland || disable_check WAYLAND wayland-client
	use xcb || (disable_check XCB_RANDR xcb-randr && disable_check XCB xcb)
	use xfce || disable_check XFCONF libxfconf
	use xrandr || disable_check XRANDR xrandr

	VERSION_MAJOR="$(ver_cut 1)"
	VERSION_MINOR="$(ver_cut 2)"

	# version comes from git, fake it
	sed -i -e "
		s/\(PROJECT_VERSION\) .*$/\1 \"r${VERSION_MAJOR}.${VERSION_MINOR}\")/
		s/\(PROJECT_VERSION_MAJOR\) .*$/\1 \"${VERSION_MAJOR}\")/" CMakeLists.txt || die "Cannot patch version"

	cmake_src_configure
}

src_install() {
	pushd "${BUILD_DIR}" || die
	dobin fastfetch
	popd

	newbashcomp completions/bash fastfetch
	insinto /usr/share/${PN}/presets
	doins presets/*

	einstalldocs
}
