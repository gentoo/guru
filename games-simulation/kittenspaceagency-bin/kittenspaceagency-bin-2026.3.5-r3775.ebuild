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

RESTRICT="mirror strip"

BDEPEND="dev-util/patchelf"
RDEPEND="
	media-libs/vulkan-loader
	virtual/dotnet-sdk:10.0
"

src_prepare() {
	default

	# scanelf: rpath_security_checks(): Security problem NULL DT_RUNPATH in
	# /var/tmp/portage/.../libRakNetDLL.so
	patchelf --remove-rpath libRakNetDLL.so || die
}

src_install() {
	insinto "/opt/kittenspaceagency"
	doins -r .

	exeinto "/opt/kittenspaceagency"
	doexe "KSA"
	doexe "Brutal.Monitor.Subprocess"

	cat > kittenspaceagency <<- 'ENDWRAPPER' || die
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
