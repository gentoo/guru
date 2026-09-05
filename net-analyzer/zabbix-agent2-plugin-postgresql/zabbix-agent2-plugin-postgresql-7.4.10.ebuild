# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PostgreSQL loadable plugin for Zabbix Agent 2"
HOMEPAGE="https://git.zabbix.com/projects/AP/repos/postgresql/browse"
SRC_URI="
	https://git.zabbix.com/rest/api/latest/projects/AP/repos/postgresql/archive?at=refs%2Ftags%2F${PV}&format=tgz
		-> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/${PN}/releases/download/${PV}/${P}-vendor.tar.xz
"

inherit go-module

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="~net-analyzer/zabbix-${PV}[agent2]"
BDEPEND=">=dev-lang/go-1.24.10"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

src_unpack() {
	mkdir "${P}" || die
	ln --symbolic "${P}/vendor" "${S}/vendor" || die
	go-module_src_unpack
}

src_install() {
	exeinto "/usr/libexec/zabbix-agent2-plugin"
	doexe zabbix-agent2-plugin-postgresql

	insinto /etc/zabbix/zabbix_agent2.d/plugins.d/
	doins postgresql.conf
}
