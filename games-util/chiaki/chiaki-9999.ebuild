# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit cmake python-single-r1 xdg

DESCRIPTION="Client for PlayStation 4 and PlayStation 5 Remote Play"
HOMEPAGE="https://git.sr.ht/~thestr4ng3r/chiaki"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://git.sr.ht/~thestr4ng3r/${PN}"
	inherit git-r3
else
	SRC_URI="https://git.sr.ht/~thestr4ng3r/${PN}/refs/download/v${PV}/${PN}-v${PV}-src.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+cli +gui +sdl +ffmpeg system-jerasure system-nanopb mbedtls test"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	gui? ( ffmpeg )
"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/libevdev
	media-libs/opus
	sdl? ( media-libs/libsdl2[joystick,haptic] )
	gui? ( dev-qt/qtcore:5 )
	gui? ( dev-qt/qtwidgets:5 )
	gui? ( dev-qt/qtgui:5 )
	gui? ( dev-qt/qtconcurrent:5 )
	gui? ( dev-qt/qtmultimedia:5 )
	gui? ( dev-qt/qtopengl:5 )
	gui? ( dev-qt/qtsvg:5 )
	!mbedtls? ( dev-libs/openssl:= )
	mbedtls? ( net-libs/mbedtls )
	ffmpeg?	( media-video/ffmpeg:= )
	system-jerasure? ( dev-libs/jerasure )
	system-nanopb? ( dev-libs/nanopb )
"

DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/protobuf[${PYTHON_USEDEP}]')
	dev-libs/protobuf
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DCHIAKI_USE_SYSTEM_JERASURE=$(usex system-jerasure)
		-DCHIAKI_USE_SYSTEM_NANOPB=$(usex system-nanopb)
		-DCHIAKI_ENABLE_TESTS=$(usex test)
		-DCHIAKI_ENABLE_CLI=$(usex cli)
		-DCHIAKI_ENABLE_GUI=$(usex gui)
		-DCHIAKI_ENABLE_FFMPEG_DECODER=$(usex ffmpeg)
		-DCHIAKI_LIB_ENABLE_MBEDTLS=$(usex mbedtls)
		-DCHIAKI_GUI_ENABLE_SDL_GAMECONTROLLER=$(usex sdl)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dolib.so "${BUILD_DIR}"/lib/*.so
	use sdl || dolib.so "${BUILD_DIR}"/setsu/*.so
}
