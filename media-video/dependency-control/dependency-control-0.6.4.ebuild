EAPI=8

inherit meson

DESCRIPTION="Package manager for Aegisub automation scripts"
HOMEPAGE="https://github.com/TypesettingTools/ffi-experiments/"

SRC_URI="
	https://github.com/TypesettingTools/ffi-experiments/archive/b8897ead55b84ec4148e900882bff8336b38f939.tar.gz
	https://github.com/evilja/gentoo-ffi-experiments/archive/refs/tags/1.tar.gz
	https://github.com/TypesettingTools/DependencyControl/archive/v${PV}-alpha.tar.gz
"

RDEPEND="
	media-video/aegisub
	dev-lua/luajson
	net-misc/curl
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/ffi-experiments-b8897ead55b84ec4148e900882bff8336b38f939"
LICENSE="ISC MIT"
SLOT="0"
KEYWORDS="~amd64"



src_install() {
	local prefix="/usr/share/aegisub/automation"
	local extra="${WORKDIR}/gentoo-ffi-experiments-1"
	local depctrl="${WORKDIR}/DependencyControl-0.6.4-alpha"
	insopts -m0755
	insinto ${prefix}/include/BM/BadMutex
	doins "${BUILD_DIR}/bad-mutex/libBadMutex.so"
	insinto ${prefix}/include/DM/DownloadManager
	doins "${BUILD_DIR}/download-manager/libDownloadManager.so"
	insinto ${prefix}/include/PT/PreciseTimer
	doins "${BUILD_DIR}/precise-timer/libPreciseTimer.so"

	insinto ${prefix}/include/BM
	doins ${extra}/BadMutex.lua
	insinto ${prefix}/include/DM
	doins ${extra}/DownloadManager.lua
	insinto ${prefix}/include/PT
	doins ${extra}/PreciseTimer.lua
	insinto ${prefix}/include/requireffi
	doins ${extra}/requireffi.lua

	# dependencycontrol

	insinto ${prefix}/include/l0/modules
	doins ${depctrl}/modules/*
	insinto ${prefix}/autoload
	doins ${depctrl}/macros/*
}
