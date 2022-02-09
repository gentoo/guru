# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 cmake

DESCRIPTION="Like neofetch but faster"
HOMEPAGE="https://github.com/LinusDierheimer/fastfetch"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LinusDierheimer/fastfetch.git"
else
	COMMIT="2ff35952510fa5a9ef655af9b328f31f7c50f689"
	VERSION_REV="2ff3595"
	SRC_URI="https://github.com/LinusDierheimer/fastfetch/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="MIT"
SLOT="0"
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

src_configure() {
	local mycmakeargs=(
		-DENABLE_RPM=no
		-DENABLE_VULKAN=$(usex vulkan)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_XCB_RANDR=$(usex xcb)
		-DENABLE_XCB=$(usex xcb)
		-DENABLE_XRANDR=$(usex xrandr)
		-DENABLE_X11=$(usex X)
		-DENABLE_GIO=$(usex gnome)
		-DENABLE_DCONF=$(usex gnome)
		-DENABLE_XFCONF=$(usex xfce)
	)

	if [[ ${PV} != *9999 ]]; then
		# version comes from git, fake it
		VERSION_MAJOR="$(ver_cut 2)"
		sed -i -e "
			s/\(PROJECT_VERSION\) .*$/\1 \"r${VERSION_MAJOR}.${VERSION_REV}\")/
			s/\(PROJECT_VERSION_MAJOR\) .*$/\1 \"${VERSION_MAJOR}\")/" CMakeLists.txt || die "Cannot patch version"
	fi

	cmake_src_configure
}

src_install() {
	if [[ ${PV} == *9999 ]]; then
		elog "REV=\"r$(git rev-list --count HEAD)\""
		elog "COMMIT=\"$(git rev-parse HEAD)\""
		elog "VERSION_REV=\"$(git rev-parse --short HEAD)\""
	fi

	pushd "${BUILD_DIR}" || die
	dobin fastfetch
	popd

	newbashcomp completions/bash fastfetch
	insinto /usr/share/${PN}/presets
	doins presets/*

	einstalldocs
}
