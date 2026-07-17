# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="The dinit service supervision + init suite"
HOMEPAGE="https://github.com/davmac314/dinit"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/davmac314/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/davmac314/${PN}/releases/download/v${PV}/${P}.tar.xz"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+cgroups +caps sysv-utils"

RDEPEND="
	caps? ( sys-libs/libcap )
	sysv-utils? (
		!sys-apps/openrc[sysv-utils(-)]
		!sys-apps/s6-linux-init[sysv-utils(-)]
		!sys-apps/systemd[sysv-utils(+)]
		!sys-apps/sysvinit
	)"
DEPEND="${RDEPEND}"

src_configure() {
	  econf \
		$(use_enable sysv-utils shutdown) \
		$(use_enable cgroups) \
		$(use_enable caps capabilities) \
		--disable-strip
}

src_install(){
	default
	if use sysv-utils; then
		dosym dinit /sbin/init
	fi
}
