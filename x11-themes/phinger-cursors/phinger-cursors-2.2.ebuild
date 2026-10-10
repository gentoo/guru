# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Most likely the most over engineered cursor theme"
HOMEPAGE="https://github.com/phisch/phinger-cursors"
SRC_URI="https://github.com/phisch/phinger-cursors/releases/download/v${PV}/${PN}-variants.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

src_install() {
	# we install into icons instead of `/usr/share/cursors`
	# this  is done for  compatibility  with `lxappearance`
	insinto /usr/share/icons/
	doins -r ./*

	# Reference `x11-themes/gentoo-xcursors` from ::gentoo
	# Add symlinks in Gentoo-specific location for
	# backwards compatibility => #848606
	mkdir -p "${ED}/usr/share/cursors/${PN}" || die
	cd "${ED}/usr/share/cursors/${PN}" || die
	for cursorset in ../../icons/*; do
	    dosym ${cursorset} /usr/share/cursors/${PN}/${cursorset##*/}
	done
}

pkg_postinst() {
	einfo "\nThe following sets were installed:"
	einfo " - phinger-cursors-dark"
	einfo " - phinger-cursors-dark-left"
	einfo " - phinger-cursors-light"
	einfo " - phinger-cursors-light-left\n"
}
