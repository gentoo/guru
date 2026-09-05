# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sailfishos/libglibutil.git"
else
	SRC_URI="https://github.com/sailfishos/${PN}/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="Library of glib utilities from the Sailfish OS project"
HOMEPAGE="https://github.com/sailfishos/libglibutil"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/libglibutil-1.0.82-respect-env.patch
)

src_configure() {
	tc-export AR CC PKG_CONFIG STRIP
	export KEEP_SYMBOLS=1
	export LIBDIR="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	emake release pkgconfig
}

src_install() {
	emake DESTDIR="${D}" \
		INSTALL_INCLUDE_DIR="${ED}"/usr/include/gutil \
		install-dev
}
