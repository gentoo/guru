# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="A space flight and rocketry simulation"
HOMEPAGE="https://ksa.ahwoo.com"
SRC_URI="
	amd64? (
		ksa_linux_v${PV}.${PR#r}.tar.gz
	)
"
S="${WORKDIR}"
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror strip fetch"

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
		# KSA defaults to x11 protocol as of r5622, only falling back to wayland if x11 (eg xwayland) is unavailable
		# "Changed KSA on Linux to start on X11 by default, using XWayland on a Wayland desktop, so detached windows work without any launch option."
		# "If X11 can't start, such as on a Wayland desktop without XWayland, it falls back to the platform GLFW would have chosen."
		# "Added the -wayland launch option to run on native Wayland instead. Detached windows are still turned off there, because Wayland can't position windows. -force-x11 is still accepted but no longer needed."
		# "Changed the KSA launch profile for devs to no longer pass -force-x11, and added a "KSA (Wayland)" profile that passes -wayland."
		exec ./KSA "$@"
	ENDWRAPPER

	dobin kittenspaceagency

	make_desktop_entry --eapi9 "/usr/bin/kittenspaceagency" \
		-d "kittenspaceagency" \
		-n "Kitten Space Agency" \
		-C "${DESCRIPTION}"
}
