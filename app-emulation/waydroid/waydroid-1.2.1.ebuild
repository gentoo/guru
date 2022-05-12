#Relaismatrix/ Messung Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 )
inherit python-single-r1

DESCRIPTION="A container-based approach to boot a full Android system on a regular Linux system"
HOMEPAGE="https://waydro.id"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="
	app-containers/lxc \
	dev-lang/python \
	dev-python/pygobject \
	dev-python/gbinder \
	net-firewall/nftables \
	net-dns/dnsmasq \
	${PYTHON_DEPS}
	"

src_install() {
	python_fix_shebang waydroid.py
	mv waydroid.py waydroid || die
	python_doscript waydroid
	python_domodule tools
	python_domodule data
	insinto "/usr/share/applications"
	doins "data/Waydroid.desktop"
	insinto "/etc/gbinder.d"
	doins "gbinder/anbox.conf"
	insinto "/usr/lib/systemd/system"
	doins "debian/waydroid-container.service"
}
