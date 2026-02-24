# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="A space flight and rocketry simulation"
HOMEPAGE="https://ksa.ahwoo.com"
SRC_URI="https://ksa-linux.ahwoo.com/download?file=setup_ksa_v${PV}.${PR#r}.tar.gz -> ${P}-${PR}.tar.gz"
S="${WORKDIR}/linux-x64"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="media-libs/vulkan-loader
	|| ( >=dev-dotnet/dotnet-sdk-10
	     >=dev-dotnet/dotnet-sdk-bin-10
	   )"

pkg_pretend() {
	ewarn "Kitten Space Agency has myriad bugs with AMD GPUs, but seems to work fine on nVidia"
}

src_install() {
	insinto "/opt/kittenspaceagency"
	doins -r .

	exeinto "/opt/kittenspaceagency"
	doexe "KSA"
	doexe "Brutal.Monitor.Subprocess"

	cat > kittenspaceagency << 'ENDWRAPPER'
#!/usr/bin/env bash

cd /opt/kittenspaceagency
XDG_SESSION_TYPE=x11 exec ./KSA "$@"
ENDWRAPPER

	dobin kittenspaceagency

	make_desktop_entry --eapi9 "/usr/bin/kittenspaceagency" \
		-d "kittenspaceagency" \
		-n "Kitten Space Agency" \
		-C "${DESCRIPTION}"
}
