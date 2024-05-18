# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Wayland event viewer"
HOMEPAGE="https://git.sr.ht/~sircmpwn/wev"
SRC_URI="https://git.sr.ht/~sircmpwn/wev/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	default
	# Respect LDFLAGS
	# Install to /usr/ not /usr/local/
	sed -e 's/$(LIBS)/$(LIBS) $(LDFLAGS)/' \
		-e 's/local//' \
		-i Makefile || die
}

src_compile() {
	tc-export CC

	default
}
