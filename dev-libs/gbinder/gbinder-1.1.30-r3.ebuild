# Copyright 1999-2022 Gentoo Authors
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
	SRC_URI="https://github.com/mer-hybris/libgbinder/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="GLib-style interface to binder"
HOMEPAGE="https://github.com/mer-hybris/libgbinder"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/libglibutil"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig
	sys-apps/sed"

PATCHES=(
	"${FILESDIR}/gbinder-1.1.30-r3-respect-env.patch"
)
src_prepare() {
	default
	sed -i -e "s|ranlib|$(tc-getRANLIB)|" \
	Makefile \
	|| die
}

src_compile() {
	emake LIBDIR="/usr/$(get_libdir)"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install-dev
}

src_test() {
	emake test
}
