# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg toolchain-funcs

DESCRIPTION="Doing phonetics by computer"
HOMEPAGE="http://www.fon.hum.uva.nl/praat/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/praat.github.io-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pango +gtk jack alsa +pulseaudio"

# This constraint is pointless, really, but we can't have ?? ( gtk pango )
# since that would always require intervention on a desktop profile and I don't
# want to make +pango silently do nothing when gtk is also on.
REQUIRED_USE="
	gtk? ( pango )"

DEPEND="
	jack? ( virtual/jack )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
	gtk? ( x11-libs/gtk+:3 )
	pango? ( x11-libs/pango )"

RDEPEND="${DEPEND}"

src_compile() {
	local audio_cflags audio_ldflags gfx

	gfx=barren
	use pango && gfx=nogui
	use gtk && gfx=gtk  # any value will do

	# The audio backend selection in the makefile is not as granular as I would
	# like so let's just do it ourselves.
	audio_cflags=
	audio_ldflags=

	if use jack; then
		audio_cflags+=" -DJACK $("$(tc-getPKG_CONFIG)" --cflags jack)" || die
		audio_ldflags+=" $("$(tc-getPKG_CONFIG)" --libs jack)" || die
	fi

	if use alsa; then
		audio_cflags+=" -DALSA $("$(tc-getPKG_CONFIG)" --cflags alsa)" || die
		audio_ldflags+=" $("$(tc-getPKG_CONFIG)" --libs alsa)" || die
	fi

	if use pulseaudio; then
		audio_cflags+=" -DHAVE_PULSEAUDIO $("$(tc-getPKG_CONFIG)" --cflags libpulse)" || die
		audio_ldflags+=" $("$(tc-getPKG_CONFIG)" --libs libpulse)" || die
	fi

	emake \
		PREFIX="${EPREFIX}/usr" \
		PRAAT_COMPILER="$(tc-get-compiler-type)" \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		LINKER_COMMAND="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		EXECUTABLE_FILE=praat \
		PRAAT_GRAPHICS="${gfx}" \
		PRAAT_AUDIO=none \
		AUDIO_COMPILER_FLAGS="${audio_cflags}" \
		AUDIO_LINKER_FLAGS="${audio_ldflags}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
