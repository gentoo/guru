# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig

DESCRIPTION="Modular status bar for somebar written in c."
HOMEPAGE="https://git.sr.ht/~raphi/someblocks"
SRC_URI="https://git.sr.ht/~raphi/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	# bug #945237
	"${FILESDIR}/${P}-c23.patch"
)

src_prepare() {
	default
	sed -i -e 's:$(LDFLAGS):$(CPPFLAGS) $(CFLAGS) $(LDFLAGS):' Makefile \
		|| die "sed fix failed. Uh-oh..."
	# prevent compilation in install phase
	sed -i -e "s/install: output/install:/g" Makefile || die
	restore_config blocks.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	einstalldocs

	save_config blocks.h
}
