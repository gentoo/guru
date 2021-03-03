# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URL="https://git.sesse.net/plocate"
else
	SRC_URI="https://plocate.sesse.net/download/plocate-${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="a much faster locate"
HOMEPAGE="https://plocate.sesse.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="io-uring"

DEPEND="
	acct-group/locate
	!sys-apps/mlocate
	io-uring? ( sys-libs/liburing:= )
"

src_configure() {
	local emesonargs=(
		-Dinstall_cron=false
		-Dinstall_systemd=false
		-Dlocategroup=locate
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	exeinto /etc/cron.daily/
	newexe "${FILESDIR}"/updatedb.cron plocate
	systemd_dounit "${FILESDIR}"/updatedb.{service,timer}
}
