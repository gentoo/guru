# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12,13} )
inherit cmake udev xdg python-any-r1

DESCRIPTION="Vietnamese Bamboo input method for Fcitx5 (Lotus branch)"
HOMEPAGE="https://lotusinputmethod.github.io/"

BAMBOO_CORE_COMMIT="9197d2cc164380a80d219f12cc90576ff2fbf5e6"
BAMBOO_URI="https://github.com/LotusInputMethod/bamboo-core/archive"
SRC_URI="
	https://github.com/LotusInputMethod/fcitx5-lotus/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${BAMBOO_URI}/${BAMBOO_CORE_COMMIT}.tar.gz -> bamboo-core-${BAMBOO_CORE_COMMIT}.tar.gz
"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openrc"

DEPEND="
	>=app-i18n/fcitx-5.0.14:5
	x11-libs/libX11
	dev-libs/libinput
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
	dev-lang/go
	${PYTHON_DEPS}
"

src_prepare() {
	rmdir bamboo/bamboo-core || die
	mv "${WORKDIR}/bamboo-core-${BAMBOO_CORE_COMMIT}" bamboo/bamboo-core || die

	cmake_src_prepare
}

src_install() {
	cmake_src_install

	# udev rules, the systemd system unit, sysusers.d and modules-load.d
	# entries are all installed directly by upstream's CMakeLists.txt

	if use openrc; then
		newinitd misc/fcitx5-lotus.openrc fcitx5-lotus-server
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload

	elog "fcitx5-lotus-server needs access to /dev/uinput for the smooth"
	elog "(uinput) typing mode. This is granted via a udev rule to the"
	elog "'uinput_proxy' system user, created by acct-user/uinput-proxy."
	elog ""
	elog "Enable the server with:"
	elog "  systemctl enable --now fcitx5-lotus-server@\$(whoami).service"
	elog ""
	elog "For OpenRC, enable the corresponding init script instead:"
	elog "  rc-update add fcitx5-lotus-server default"
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
