# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_COMMIT="3e69680cc2dd607a27731aa7d550a66d2ecb1ddf"

MY_PN="resynthesizer"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Suite of GIMP plugins for texture synthesis"
HOMEPAGE="https://github.com/bootchk/resynthesizer"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bootchk/resynthesizer.git"
	EGIT_BRANCH="resynthesizer3"
elif [[ ${PV} == *_p* ]] ; then
	SRC_URI="https://github.com/bootchk/resynthesizer/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"
else
	SRC_URI="https://github.com/bootchk/resynthesizer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64"
fi

IUSE="debug +glib threads +translations animate deep-progress"
REQUIRED_USE="debug? ( glib )"
RESTRICT="test" # broken upstream tests

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
		$(meson_use translations install-translations)
		$(meson_use animate synth-animate)
		$(meson_use deep-progress synth-deep-progress)
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
