# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://codeberg.org/dnkl/tllist/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/tllist.git"
fi

DESCRIPTION="A C header file only implementation of a typed linked list"
HOMEPAGE="https://codeberg.org/dnkl/tllist"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	meson_src_install
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
}
