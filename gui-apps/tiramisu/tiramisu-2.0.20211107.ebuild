# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala

DESCRIPTION="minimalistic desktop notifications provider"
HOMEPAGE="https://github.com/Sweets/tiramisu"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sweets/tiramisu"
else
	SRC_URI="https://github.com/Sweets/tiramisu/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-libs/glib:2[dbus]"
DEPEND="${RDEPEND}"
BDEPEND="$(vala_depend)"

PATCHES=( "${FILESDIR}/tiramisu-2.0.20211107-pkg-config.patch" )

src_prepare() {
	default
	vala_src_prepare
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
