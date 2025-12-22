# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )

inherit python-single-r1

DESCRIPTION="Minimal NetworkManager TUI with complete 802.1X enterprise WiFi support"
HOMEPAGE="https://github.com/Zeus-Deus/gazelle-tui"
SRC_URI="https://github.com/Zeus-Deus/gazelle-tui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	net-misc/networkmanager
	net-vpn/networkmanager-openvpn
	net-vpn/wireguard-tools
	$(python_gen_cond_dep '
		>=dev-python/textual-0.47.0[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
PATCHES=(
	"${FILESDIR}"/patch-app-1.7.0.patch
)

src_install()
{
	python_moduleinto ${PN/-/_}
	python_domodule network.py app.py
	python_doscript gazelle
}
