# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
inherit cmake udev xdg python-any-r1

DESCRIPTION="Vietnamese Bamboo input method for Fcitx5 (Lotus branch)"
HOMEPAGE="https://lotusinputmethod.github.io/"
SRC_URI="https://github.com/LotusInputMethod/fcitx5-lotus/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	>=app-i18n/fcitx-5.0.14:5
	dev-libs/libevdev
	dev-libs/libinput
	x11-libs/libnotify
	virtual/libudev
"
RDEPEND="${DEPEND}
	acct-user/uinput-proxy
	sys-apps/acl
	dev-python/qtpy
	dev-python/dbus-python
"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
	virtual/pkgconfig
	${PYTHON_DEPS}
"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DINSTALL_OPENRC=ON
		-DLOTUS_UINPUT_PROXY_USER="uinput-proxy"
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	newdoc lotus/LICENSE.bamboo-core LICENSE.bamboo-core
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload

	elog "fcitx5-lotus-server needs access to /dev/uinput for the smooth"
	elog "(uinput) typing mode. This is granted via a udev rule to the"
	elog "'uinput-proxy' system user, created by acct-user/uinput-proxy."
	elog ""
	elog "Enable the server with:"
	elog "  systemctl enable --now fcitx5-lotus-server@\$(whoami).service"
	elog ""
	elog "For OpenRC, enable the corresponding multiplexed service instead:"
	elog "  ln -s /etc/init.d/fcitx5-lotus /etc/init.d/fcitx5-lotus.\$(whoami)"
	elog "  rc-update add fcitx5-lotus.\$(whoami) default"
	elog "  rc-service fcitx5-lotus.\$(whoami) start"
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
