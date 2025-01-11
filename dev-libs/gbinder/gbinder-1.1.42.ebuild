# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
SLOT="0"

DEPEND="dev-libs/libglibutil
	dev-libs/glib"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	sys-apps/sed
"

PATCHES=(
	"${FILESDIR}/gbinder-1.1.36-respect-env.patch"
	"${FILESDIR}/gbinder-1.1.42-C23-compat.patch"
)

src_prepare() {
	sed -i -e "s|ranlib|$(tc-getRANLIB)|" \
		Makefile || die
	default
}

src_compile() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		DESTDIR="${D}" \
		INSTALL_INCLUDE_DIR="${ED}/usr/include/gbinder" \
		install-dev
}
