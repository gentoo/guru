# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="tail command with colors"
HOMEPAGE="https://github.com/joakim666/colortail"

SRC_URI="https://github.com/joakim666/colortail/releases/download/${PV}/${P}.tar.gz"

inherit autotools

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}"/01_colorize_default.patch
	"${FILESDIR}"/02_adding_option.patch
)

DOCS=(TODO README ChangeLog BUGS AUTHORS example-conf/conf.{daemon,kernel,messages,secure,xferlog} )

src_prepare() {
	eautoreconf
	default
}

src_compile() {
	emake || die
}

src_install() {
	emake install DESTDIR="${ED}" || die
	doman "${FILESDIR}/${PN}.1"
	dodoc ${DOCS[@]}
	insinto /etc/colortail
	newins example-conf/conf.messages conf.colortail
}
