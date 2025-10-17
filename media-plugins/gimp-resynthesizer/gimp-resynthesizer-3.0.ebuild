# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Suite of GIMP plugins for texture synthesis"
HOMEPAGE="https://github.com/bootchk/resynthesizer"
SRC_URI="https://github.com/bootchk/resynthesizer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/resynthesizer-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug +glib threads test +translations animate deep-progress libheal"

RESTRICT="!test? ( test )"

DEPEND="
	>=media-gfx/gimp-3.0.0
	glib? ( dev-libs/glib:2 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use debug synth-debug)
		$(meson_use glib synth-use-glib)
		$(meson_use threads synth-threaded)
		$(meson_use test install-test)
		$(meson_use translations install-translations)
		$(meson_use animate synth-animate)
		$(meson_use deep-progress synth-deep-progress)
		$(meson_use libheal build-libheal)
	)

	# If using glib, we can choose glib threads, otherwise force posix
	if use glib && use threads; then
		emesonargs+=( -Dsynth-use-glib-threads=true )
	else
		emesonargs+=( -Dsynth-use-glib-threads=false )
	fi

	meson_src_configure
}

src_install() {
	addwrite "/usr/$(get_libdir)/gimp/3.0/plug-ins"

	meson_src_install
}
