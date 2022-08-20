# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Application/browser chooser"
HOMEPAGE="https://apps.gnome.org/app/re.sonny.Junction/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/sonnyp/Junction.git"
	inherit git-r3
else
	SRC_URI="https://github.com/sonnyp/Junction/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${P/j/J}"
fi

LICENSE="GPL-3+"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	meson_src_configure \
		--datadir=/usr/share
}

src_install() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
