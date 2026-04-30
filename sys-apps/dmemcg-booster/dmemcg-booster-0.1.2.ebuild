# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

DESCRIPTION="Service for enabling and controlling dmem cgroup limits for boosting foreground games"
HOMEPAGE="https://gitlab.steamos.cloud/holo/dmemcg-booster"
CRATES="
	dbus@0.9.10
	libc@0.2.182
	libdbus-sys@0.2.7
	pkg-config@0.3.32
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
"

inherit cargo systemd

SRC_URI="
	${CARGO_CRATE_URIS}
	https://gitlab.steamos.cloud/holo/${PN}/-/archive/${PV}/${P}.tar.bz2
"

S="${WORKDIR}/${P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-apps/dbus
	x11-libs/libdrm
"
RDEPEND="
	${DEPEND}
	sys-apps/systemd:=
"
BDEPEND="
	virtual/pkgconfig
"

src_install() {
	cargo_src_install

	systemd_dounit "${S}/dmemcg-booster-system.service"
	systemd_douserunit "${S}/dmemcg-booster-user.service"

	einstalldocs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "  systemctl enable --now dmemcg-booster-system.service"
		einfo "  systemctl --user --global enable dmemcg-booster-user.service"
	fi
	einfo "emerge installed the unit files, but left them disabled."

	elog "The kernel dmem cgroup controller must be present. You are running"
	elog "kernel ${KV_FULL:-$(uname -r)}; dmem cgroup support requires at"
	elog "least the patches carried by linux-cachyos or a kernel built with"
	elog "the appropriate out-of-tree patch set."
}

pkg_prerm() {
	einfo "If you enabled the services manually, disable them before removing this package:"
	einfo "  systemctl disable --now dmemcg-booster-system.service"
	einfo "  systemctl --user --global disable dmemcg-booster-user.service"
}
