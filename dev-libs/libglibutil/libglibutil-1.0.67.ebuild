# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sailfishos/libglibutil.git"
else
	SRC_URI="https://github.com/sailfishos/libglibutil/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Library of glib utilities"
HOMEPAGE="https://github.com/sailfishos/libglibutil"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/glib"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake KEEP_SYMBOLS=1
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install-dev
}
