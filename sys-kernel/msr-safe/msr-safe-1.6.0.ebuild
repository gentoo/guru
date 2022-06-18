# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod systemd udev

DESCRIPTION="Allows safer access to model specific registers (MSRs)"
HOMEPAGE="https://github.com/LLNL/msr-safe"
SRC_URI="https://github.com/LLNL/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="slurm"

DEPEND="slurm? ( sys-cluster/slurm )"
RDEPEND="
	${DEPEND}
	virtual/udev
"

BUILD_TARGETS="all"
MODULE_NAMES="msr-safe(misc:${S})"

src_compile() {
	linux-mod_src_compile
	use slurm && emake spank
}

src_install() {
	linux-mod_src_install
	DESTDIR="${D}" libdir="$(get_libdir)" prefix="/usr" emake install
	use slurm && DESTDIR="${D}" libdir="$(get_libdir)" prefix="/usr" emake install-spank
	dodoc README.md
	systemd_dounit rpm/msr-safe.service
	newsbin rpm/msr-safe.sh msr-safe
	udev_dorules rpm/10-msr-safe.rules
	insinto /etc/sysconfig
	newins rpm/msr-safe.sysconfig msr-safe
	insinto /usr/share/msr-safe
	doins -r allowlists
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
