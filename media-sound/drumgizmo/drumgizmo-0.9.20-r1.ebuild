# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.drumgizmo.org/${PN}.git"
else
	SRC_URI="https://www.drumgizmo.org/releases/${P}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Audio sampler plugin and stand-alone app that simulates a real drum kit"
HOMEPAGE="https://drumgizmo.org/"

inherit autotools

LICENSE="LGPL-3+"
SLOT="0"
IUSE="alsa cli jack +lv2 midi nls test"
REQUIRED_USE="|| ( cli lv2 )"
RESTRICT="!test? ( test )"

# TODO:
# Unbundle media-libs/zita-resampler. This requires a massive patch for build system.

RDEPEND="
	media-libs/libsndfile
	cli? (
		alsa? ( media-libs/alsa-lib )
		jack? ( virtual/jack )
		midi? ( media-libs/libsmf )
	)
	lv2? (
		media-libs/lv2
		x11-libs/libX11
		x11-libs/libXext
	)
"
DEPEND="${RDEPEND}
	test? (
		dev-libs/serd
		media-libs/lilv
	)
"
BDEPEND="
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.9.20-configure-portable-shell.patch
	"${FILESDIR}"/${PN}-0.9.20-include-cstdint.patch
	"${FILESDIR}"/${PN}-0.9.20-disable-lv2-test.patch
	"${FILESDIR}"/${PN}-0.9.20-disable-translation-test.patch
	"${FILESDIR}"/${PN}-0.9.20-fix-painter-test.patch
)

pkg_pretend() {
	if ! use cli; then
		use alsa && ewarn "Ignoring USE=alsa since cli is disabled"
		use jack && ewarn "Ignoring USE=jack since cli is disabled"
		use midi && ewarn "Ignoring USE=midi since cli is disabled"
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-gui=x11
		# requres VST2 SDK
		--disable-vst
		# all SSE conditionals were removed in 0.9.16
		--enable-sse=no
		$(use_enable cli)
		$(use_enable lv2)
		$(use_with nls)
		$(use_with test)
	)

	if use cli; then
		myeconfargs+=(
			$(use_enable alsa input-alsamidi)
			$(use_enable alsa output-alsa)
			$(use_enable jack input-jackmidi)
			$(use_enable jack output-jackaudio)
			$(use_enable midi input-midifile)
		)
	else
		myeconfargs+=(
			--disable-input-alsamidi
			--disable-output-alsa
			--disable-input-jackmidi
			--disable-output-jackaudio
			--disable-input-midifile
		)
	fi

	econf "${myeconfargs[@]}"
}
