# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NVIDIA GPU loadable plugin for Zabbix Agent 2."
HOMEPAGE="https://git.zabbix.com/projects/AP/repos/nvidia-gpu/browse"
SRC_URI="
	https://git.zabbix.com/rest/api/latest/projects/AP/repos/nvidia-gpu/archive?at=refs%2Ftags%2F${PV}&format=tgz
		-> ${P}.tar.gz
	https://vimja.cloud/public.php/dav/files/z59eKDyLFokW2KK/${CATEGORY}/${PN}/${P}-vendor.tar.xz
"

inherit go-module

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	~net-analyzer/zabbix-${PV}[agent2]
	x11-drivers/nvidia-drivers
"
BDEPEND="x11-drivers/nvidia-drivers"

DOCS=( "README.md" )

src_prepare() {
	default
	# See https://bugs.gentoo.org/975428
	sed --in-place 's/^#cgo linux LDFLAGS: -ldl/& -lnvidia-ml/' pkg/nvml/nvml_linux.go || die
}

src_install() {
	exeinto "/usr/libexec/zabbix-agent2-plugin"
	doexe zabbix-agent2-plugin-nvidia-gpu

	insinto /etc/zabbix/zabbix_agent2.d/plugins.d/
	doins nvidia.conf
}
