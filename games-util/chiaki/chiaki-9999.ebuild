# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
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
	dev-libs/openssl
	dev-qt/qtconcurrent
	dev-qt/qtmultimedia
	dev-qt/qtsvg
	media-libs/libsdl2
	media-libs/opus
	media-video/ffmpeg
"

DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/protobuf-python[${PYTHON_USEDEP}]')
	dev-libs/protobuf
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCMAKE_BUILD_TYPE=Release
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPYTHON_LIBRARY="$(python_get_library_path)"
		-DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
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