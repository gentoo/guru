# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 optfeature

MY_PN="${PN}-kernel-module"
COMMIT="c8798d698f9af5daf2be1be3d998e66374698271"
DESCRIPTION="Kernel module edition of the Cycles Per Instruction (2014) album"
HOMEPAGE="http://netcat.co https://github.com/usrbinnc/netcat-cpi-kernel-module"
SRC_URI="https://github.com/usrbinnc/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	sed '/module_exit/a\MODULE_LICENSE("Proprietary");' -i netcat_main.c || die
}

src_compile() {
	local modlist=( netcat=misc )
	local modargs=( KERNELDIR="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	optfeature "playing the album" media-sound/vorbis-tools[ogg123]
}
