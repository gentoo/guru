# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod optfeature

MY_PN="${PN}-kernel-module"
COMMIT="c8798d698f9af5daf2be1be3d998e66374698271"
DESCRIPTION="Kernel module edition of the Cycles Per Instruction (2014) album"
HOMEPAGE="http://netcat.co https://github.com/usrbinnc/netcat-cpi-kernel-module"
SRC_URI="https://github.com/usrbinnc/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	virtual/linux-sources
	sys-kernel/linux-headers
"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="clean all"
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
	MODULE_NAMES="netcat(misc)"
}

src_prepare() {
	default
	sed '/module_exit/a\MODULE_LICENSE("Proprietary");' -i netcat_main.c || die
}

pkg_postinst() {
	linux-mod_pkg_postinst
	optfeature "playing the album" media-sound/vorbis-tools[ogg123]
}
