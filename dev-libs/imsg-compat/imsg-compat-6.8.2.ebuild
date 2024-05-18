# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="linux port of OpenBSD imsg"

HOMEPAGE="https://man.openbsd.org/imsg_init.3
	https://github.com/bsd-ac/imsg-compat
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bsd-ac/imsg-compat.git"
else
	SRC_URI="https://github.com/bsd-ac/imsg-compat/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

src_prepare() {
	default
	sed "s/@LIBDIR@/$(get_libdir)/" -i libimsg.pc.in || die
}

src_configure() {
	tc-export CC AR
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREIFX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install
	if ! use static-libs ; then
		find "${ED}"/usr/$(get_libdir) -name "*.a" -delete || die
	fi
}
