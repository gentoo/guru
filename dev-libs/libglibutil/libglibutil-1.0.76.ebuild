# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sailfishos/libglibutil.git"
else
	SRC_URI="https://github.com/sailfishos/libglibutil/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="Library of glib utilities from sailfishos project"
HOMEPAGE="https://github.com/sailfishos/libglibutil"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/glib"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/libglibutil-1.0.76-respect-env.patch"
)

src_compile() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		DESTDIR="${D}" \
		INSTALL_INCLUDE_DIR="${ED}/usr/include/gutil" \
		install-dev
}
