# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Simple xargs and apply replacement with sane defaults"
HOMEPAGE="https://github.com/leahneukirchen/xe/"
SRC_URI="https://github.com/leahneukirchen/xe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lang/perl )"

src_prepare() {
	default
	# https://github.com/leahneukirchen/xe/pull/11
	sed '/^CFLAGS/{s/=/:=/;s/-g -O2//;s/$/ $(CFLAGS)/}' \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
