# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Required tools for Jool"
HOMEPAGE="https://nicmx.github.io/Jool/en/index.html"
SRC_URI="https://github.com/NICMx/Jool/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="iptables"

DEPEND="
	dev-libs/libnl:3
	iptables? ( net-firewall/iptables )
"
RDEPEND="${DEPEND}
	!iptables? ( net-firewall/nftables )
"

src_configure() {
	local myeconfargs=(
		--with-bash-completion-dir=no
		--with-xtables=$(usex iptables)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	local myemakeargs=(
		DESTDIR="${D}"
		XTABLES_SO_DIR=$($(tc-getPKG_CONFIG) xtables --variable=xtlibdir)
	)
	emake "${myemakeargs[@]}" install
	einstalldocs
}
