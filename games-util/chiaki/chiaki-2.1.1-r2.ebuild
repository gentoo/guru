# Copyright 1999-2024 Gentoo Authors
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
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+cli +gui test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/jerasure
	dev-libs/libevdev
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5
	dev-qt/qtopengl:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/libsdl2
	media-libs/opus
	media-video/ffmpeg:=
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
		-DCHIAKI_USE_SYSTEM_JERASURE=TRUE
		-DCHIAKI_ENABLE_TESTS=$(usex test)
		-DCHIAKI_ENABLE_CLI=$(usex cli)
		-DCHIAKI_ENABLE_GUI=$(usex gui)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dolib.so "${BUILD_DIR}"/lib/*.so
	dolib.so "${BUILD_DIR}"/setsu/*.so
}
