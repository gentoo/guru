# Copyright 2026 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

if [[ "${PV}" == "9999"* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/measurement-factory/ipv4-heatmap"
else
	EGIT_COMMIT="3b4b4f87298c84cd1d501e77948c1101ddea1cf6"
	SRC_URI="https://github.com/measurement-factory/ipv4-heatmap/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Generate Hilbert curve heatmaps of the IPv4 address space"
HOMEPAGE="https://github.com/measurement-factory/ipv4-heatmap"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/gd:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	sed -i \
		-e '1aPKG_CONFIG ?= pkg-config' \
		-e 's,^LIBS=.*,LIBS = -lm `${PKG_CONFIG} --libs gdlib`,' \
		-e 's,^CFLAGS=.*,CFLAGS += `${PKG_CONFIG} --cflags gdlib`,' \
		-e 's,^LDFLAGS=.*,#LDFLAGS,' \
		Makefile || die
}

src_configure() {
	tc-export CC PKG_CONFIG
}

src_install() {
	einstalldocs

	dobin ipv4-heatmap
	doman ipv4-heatmap.1

	dodoc labels/iana/iana-labels.txt
}
