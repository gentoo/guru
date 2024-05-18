# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="wlr-output-power-management-v1 client"
HOMEPAGE="https://git.sr.ht/~leon_plickat/wlopm/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~leon_plickat/wlopm"
else
	SRC_URI="https://git.sr.ht/~leon_plickat/wlopm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/wayland-protocols"

src_install() {
	# Need to install to /usr instead of /usr/local
	# and the Makefile doens't handle DESTDIR properly
	emake PREFIX="${D}"/usr install
}
