# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Generates ASCII-art penis of arbitrary length"
HOMEPAGE="https://gitlab.com/ssterling/varlpenis"
EGIT_REPO_URI="https://gitlab.com/ssterling/varlpenis.git https://github.com/ssterling/varlpenis.git"
EGIT_COMMIT="v${PV}"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-build/bmake"

src_configure() {
	local myconf
	econf --ignore-invalid-arguments \
		--use-color-ansi \
		--use-posixtime \
		--use-fullwidth \
		${myconf}
}

src_compile() {
	bmake varlpenis
}

src_install() {
	bmake DESTDIR="${D}" install
	dodoc BUGS.md
	dodoc CHANGELOG.md
	dodoc README.md
}
