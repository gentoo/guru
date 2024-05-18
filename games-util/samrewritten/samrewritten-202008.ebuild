# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Steam Achievement Manager For Linux"
HOMEPAGE="https://github.com/PaulCombal/SamRewritten/"

if [ ${PV} = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PaulCombal/SamRewritten.git"
else
	SRC_URI="https://github.com/PaulCombal/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/SamRewritten-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+zenity"

DEPEND="
	dev-cpp/gtkmm:3.0
	dev-libs/yajl
	net-libs/gnutls
"
RDEPEND="
	${DEPEND}
	zenity? ( gnome-extra/zenity )
"

src_install() {
	emake LIBDIR=$(get_libdir) DESTDIR="${ED}" install
}

pkg_postinst() {
	xdg_pkg_postinst
	ewarn "${P} requires Steam to be installed through the steam-overlay."
}
