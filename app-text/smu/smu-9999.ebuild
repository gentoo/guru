# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Gottox/smu.git"
else
	SRC_URI="https://github.com/Gottox/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Simple markup - markdown like syntax"
HOMEPAGE="https://github.com/Gottox/smu"

LICENSE="MIT"
SLOT="0"

pkg_setup() {
	export CC="$(tc-getCC)"
}

src_prepare() {
	default
	sed -i \
		-e '/^CC/d' \
		-e '/^CFLAGS/ s|-g -O0 ||;s|-Werror ||;s|^CFLAGS =|CFLAGS +=|;' \
		-e '/^LDFLAGS/ s|^LDFLAGS =|LDFLAGS +=|' \
		config.mk || die "sed failed"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${ED}" install
	dodoc "documentation"
}
