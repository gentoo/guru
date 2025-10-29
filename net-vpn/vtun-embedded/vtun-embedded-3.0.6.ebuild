# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools systemd

DESCRIPTION="Create tunnels over TCP/IP networks with shaping, encryption, and compression"
HOMEPAGE="https://github.com/leakingmemory/vtun-embedded"
SRC_URI="https://github.com/leakingmemory/vtun-embedded/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm64 ~ppc ~sparc ~x86"
IUSE="systemd lzo socks5 ssl zlib"

RDEPEND="
	lzo? ( dev-libs/lzo:2 )
	socks5? ( net-proxy/dante )
	ssl? ( dev-libs/openssl:0= )
	zlib? ( sys-libs/zlib )
	dev-libs/libbsd"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
"

DOCS=( ChangeLog Credits FAQ README README.Setup README.Shaper TODO )
CONFIG_CHECK="~TUN"

src_prepare() {
	default
	eautoreconf
	sed -i -e '/^LDFLAGS/s|=|+=|g' Makefile.in || die
	sed -i 's:$(BIN_DIR)/strip $(DESTDIR)$(SBIN_DIR)/vtunemd::' Makefile.in || die
}

src_configure() {
	econf \
		$(use_enable ssl) \
		$(use_enable zlib) \
		$(use_enable lzo) \
		$(use_enable socks5 socks) \
		--enable-shaper
}

src_install() {
	default
	newinitd "${FILESDIR}"/vtun-embedded.rc vtun-embedded
	insinto /etc
	doins "${FILESDIR}"/vtunemd-start.conf
	rm -r "${ED}"/var || die
	if use systemd; then
		insinto /etc/vtunemd
		newins "${S}"/scripts/sample-client.env.systemd sample-client.env
	fi
	systemd_newunit "${S}"/scripts/vtunemd.service.systemd vtunemd.service
	systemd_newunit "${S}"/scripts/vtunemd-client.service.systemd vtunemd@.service
}
