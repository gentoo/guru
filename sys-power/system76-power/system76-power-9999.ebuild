# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo

DESCRIPTION="System76 Power Management Tool"
HOMEPAGE="https://github.com/pop-os/system76-power"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/pop-os/system76-power"
else
	SRC_URI="
		https://github.com/pop-os/system76-power/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	BSD ISC MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"

DEPEND="virtual/libusb:1"
RDEPEND="
	${DEPEND}
	sys-apps/dbus
	sys-auth/polkit
"
BDEPEND="virtual/pkgconfig"

src_unpack(){
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	# Install the Rust binary using the cargo eclass as the Makefile hardcodes the release path
	sed -i '/\s*install -D -m 0755/d' Makefile || die
	default
}

src_configure() {
	if [[ ${PV} == *9999* ]]; then
		# prevent network access during src_install due to git crate sysfs-class
		cargo_src_configure --frozen
	else
		cargo_src_configure
	fi
}

src_install(){
	cargo_src_install
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	elog "Enable the service: 'systemctl enable --now com.system76.PowerDaemon.service'"
}

pkg_postinst(){
	if ! has_version sys-apps/systemd; then
		ewarn "${PN} is not functional without sys-apps/systemd at this point."
	fi
}
