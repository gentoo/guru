# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit python-single-r1

DESCRIPTION="Create and run optimised Windows, macOS and Linux desktop virtual machines"
HOMEPAGE="https://github.com/quickemu-project/quickemu"
SRC_URI="https://github.com/quickemu-project/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	>=app-emulation/qemu-6.0.0[gtk,sdl,spice,virtfs]
	>=app-shells/bash-4.0:=
	app-cdr/cdrtools
	app-crypt/swtpm
	app-misc/jq
	net-misc/spice-gtk[gtk3]
	net-misc/wget
	net-misc/zsync
	sys-apps/usbutils
	sys-apps/util-linux
	|| ( sys-firmware/edk2 sys-firmware/edk2-bin )
	sys-process/procps
	x11-apps/xrandr
	x11-misc/xdg-user-dirs
"
RDEPEND="${DEPEND}"

src_install() {
	python_doscript chunkcheck
	dobin quick{emu,get,report}
	doman docs/*.{1,5}
}
