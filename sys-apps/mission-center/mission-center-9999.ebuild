# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

PATHFINDER_COMMIT=21ec6fa933547636bc6c5ee8f0dd4a0ea3fcd062
NVTOP_COMMIT=be47f8c560487efc6e6a419d59c69bfbdb819324

inherit git-r3 gnome2-utils meson python-any-r1 xdg

DESCRIPTION="Monitor your CPU, Memory, Disk, Network and GPU usage."
HOMEPAGE="https://missioncenter.io/"


EGIT_REPO_URI="https://gitlab.com/mission-center-devs/mission-center.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}-v${PV}"
SRC_URI="
	https://github.com/Syllo/nvtop/archive/${NVTOP_COMMIT}.tar.gz -> nvtop-${NVTOP_COMMIT}.tar.gz
"

S="${WORKDIR}/${PN}-v${PV}"
BUILD_DIR="${S}-build"
LICENSE="GPL-3+"
SLOT="0"
IUSE="debug"
RESTRICT="network-sandbox"

DEPEND="
	dev-libs/wayland
	gui-libs/libadwaita
	>=gui-libs/gtk-4
	gui-libs/egl-gbm
	virtual/rust
	virtual/udev
	x11-libs/libdrm
"
RDEPEND="
	${DEPEND}
	sys-apps/dmidecode
"
BDEPEND="
	${PYTHON_DEPS}
	dev-libs/gobject-introspection
	>=dev-util/meson-0.63
	dev-util/blueprint-compiler
"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	unpack nvtop-${NVTOP_COMMIT}.tar.gz
	GATHERER_BUILD_DIR=$(usex debug debug release)
	mkdir -p "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native" || die
	mv nvtop-${NVTOP_COMMIT} "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native" || die
}

src_prepare() {
	eapply_user
	GATHERER_BUILD_DIR=$(usex debug debug release)
	cd "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native/nvtop-${NVTOP_COMMIT}" || die
	find "${S}/src/sys_info_v2/gatherer/3rdparty/nvtop/patches" -type f -name 'nvtop-*' -exec sh -c 'patch -p1 < {}' \; || die
}

src_configure() {
	local emesonargs=(
		--buildtype $(usex debug debug release)
		--prefix=/usr
	)
	meson_src_configure
}

src_test() {
	# patch the appstream-util validate command to use --nonet when validating the urls
	sed -i "s/args: \['validate',/args: \['validate', '--nonet',/g" "${S}/data/meson.build" || die
	meson_src_test
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="
	usr/bin/missioncenter
	usr/bin/missioncenter-gatherer
"
