# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vowstar/${PN}.git"
else
	MY_P="${PN}-upstream-${PV}"
	SRC_URI="https://github.com/vowstar/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv"
fi

DESCRIPTION="ZFS Automatic Scrub/Trim for Linux"
HOMEPAGE="https://github.com/zfsonlinux"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="
	sys-fs/zfs
	virtual/cron
"

DOCS=( README )

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
	einstalldocs
}

pkg_postinst() {
	ewarn "jobs are enabled by default for ALL zfs pools"
	ewarn "enable default-exclude flag, or"
	ewarn "set com.sun:auto-scrub=false to disable auto scrub"
	ewarn "set com.sun:auto-trim=false to disable auto trim"
}
