# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal

DESCRIPTION="ALSA PCM to play audio on sndio servers"
HOMEPAGE="https://github.com/Duncaen/alsa-sndio"
SRC_URI="https://github.com/Duncaen/alsa-sndio/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-sound/sndio:=[${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare() {
	fix_libdir() {
		sed -i "s;/lib/alsa-lib/;/$(get_libdir)/alsa-lib/;" "${BUILD_DIR}/Makefile" || die "Failed changing libdir"
	}

	default
	multilib_copy_sources
	multilib_foreach_abi fix_libdir
}

multilib_src_compile() {
	emake CC="${CC:-gcc}"
}

multilib_src_install() {
	export PREFIX="/usr"

	default
}
