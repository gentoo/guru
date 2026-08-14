# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A sophisticated low memory handler for Linux"
HOMEPAGE="https://github.com/hakavlad/nohang"
LICENSE="MIT"
SLOT="0"
IUSE="systemd"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hakavlad/nohang.git"
	EGIT_BRANCH="dev"
else
	SRC_URI="https://github.com/hakavlad/nohang/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	dev-lang/python
	systemd? ( sys-apps/systemd )
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}"

src_install() {
	if use systemd; then
		PREFIX="/usr" SYSCONFDIR="/etc" emake DESTDIR="${D}" install
	else
		PREFIX="/usr" SYSCONFDIR="/etc" emake DESTDIR="${D}" -B install-openrc
	fi
}
