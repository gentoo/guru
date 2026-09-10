# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mer-hybris/libgbinder.git"
else
	MY_PN="lib${PN}"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/mer-hybris/libgbinder/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="GLib-style interface to binder"
HOMEPAGE="https://github.com/mer-hybris/libgbinder"
LICENSE="BSD"
SLOT="0/1.1.52"

DEPEND="
	dev-libs/libglibutil
	dev-libs/glib:2
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/gbinder-1.1.52-respect-env.patch
)

src_configure() {
	tc-export AR CC PKG_CONFIG RANLIB STRIP
	export KEEP_SYMBOLS=1
	export LIBDIR="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	emake release pkgconfig
	emake -C tools release
}

src_install() {
	local -x DESTDIR="${D}"
	emake INSTALL_INCLUDE_DIR="${ED}"/usr/include/gbinder install-dev
	emake INSTALL_BIN_DIR="${ED}"/usr/bin -C tools install
}
