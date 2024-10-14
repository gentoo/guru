# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Required tools for Jool"
HOMEPAGE="https://nicmx.github.io/Jool/en/index.html"
SRC_URI="https://github.com/NICMx/Jool/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+iptables"

DEPEND="
	iptables? ( net-firewall/iptables )
	dev-libs/libnl:3
"
RDEPEND="
	|| (
	net-firewall/nftables
	iptables? ( net-firewall/iptables )
	)
"

src_configure() {
	econf \
		--with-bash-completion-dir=no \
		$(use_with iptables xtables)
}
