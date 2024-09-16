# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV/./}
DESCRIPTION="OpenBSD manual pages"
HOMEPAGE="https://man.openbsd.org"
BASE_URI="https://ftp.openbsd.org/pub/OpenBSD/${PV}/amd64"
SRC_URI="
	${BASE_URI}/comp${MY_PV}.tgz
	${BASE_URI}/man${MY_PV}.tgz
"
S="${WORKDIR}/usr/share/man"

LICENSE="BSD BSD-2 BSD-4 ISC MIT icu openssl"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~s390 ~sparc ~x86"

src_prepare() {
	default

	ebegin "Renaming sections to prevent collision"
	find . -maxdepth 1 -name 'man*' -execdir mv '{}' '{}'bsd \; || die
	find . -type f -execdir mv '{}' '{}'bsd \; || die
	find . -type f -execdir sed -i '{}' \
		-e 's:^\.Dt \S\+ \S\+:\0bsd:' \
		-e 's:^\(\.TH \S\+ "\?\)\([0-9a-z]\+\):\1\2bsd:' \; || die
	eend 0
}

src_install() {
	insinto /usr/share/man
	doins -r *
}

pkg_postinst() {
	elog "To read an OpenBSD manpage, add 'bsd' suffix to its section name."
	elog "For example:"
	elog "$ man -s 9bsd style"
}
