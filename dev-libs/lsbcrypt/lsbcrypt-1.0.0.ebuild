# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="libcrypt Wrapper for LiteSpeedTech"
HOMEPAGE="https://github.com/litespeedtech/libbcrypt/"
EGIT_REPO_URI="https://github.com/litespeedtech/libbcrypt/"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	eapply_user
}

src_configure() {
	true
}

src_compile() {
	make
}

src_install() {
	true
}

pkg_preinst() {
	mkdir -p ${D}/usr/lib/
	mkdir -p ${D}/usr/include/
	cp -a ${S}/bcrypt.h ${D}/usr/include/
	cp -a ${S}/bcrypt.a ${D}/usr/lib/
}
