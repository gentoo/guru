# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit xdg cmake optfeature python-single-r1 readme.gentoo-r1

MY_P="QLivePlayer-${PV}"

DESCRIPTION="A player and recorder for live streams and videos with danmaku support"
HOMEPAGE="https://github.com/IsoaSFlus/QLivePlayer"
SRC_URI="https://github.com/IsoaSFlus/QLivePlayer/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtdeclarative-5.15:5
	>=dev-qt/qtgui-5.15:5
	>=dev-qt/qtnetwork-5.15:5
	>=dev-qt/qtwidgets-5.15:5
"
RDEPEND="
	${COMMON_DEPEND}
	$(python_gen_cond_dep '
		dev-python/aiohttp[${PYTHON_USEDEP}]
	')
	media-video/ffmpeg
	media-video/mpv
	net-misc/curl
	>=dev-qt/qtquickcontrols-5.15:5
	>=dev-qt/qtquickcontrols2-5.15:5
	>=dev-qt/qtsvg-5.15:5
"
DEPEND="
	${COMMON_DEPEND}
	kde-frameworks/extra-cmake-modules:5
"

src_prepare() {
	xdg_environment_reset
	cmake_src_prepare
	# respect PYTHON_SINGLE_TARGET
	grep 'p.start("python3", args);' src/qlphelper/bilivideo.cpp >/dev/null || die
	sed -i "s/python3/${EPYTHON}/" src/qlphelper/bilivideo.cpp || die
	grep 'dmcPyProcess->start("python3", dmcPy);' \
		src/qlphelper/danmakulauncher.cpp >/dev/null || die
	sed -i "s/python3/${EPYTHON}/" src/qlphelper/danmakulauncher.cpp || die
	grep 'proc->start("python3", args);' \
		src/qlphelper/streamfinder.cpp >/dev/null || die
	sed -i "s/python3/${EPYTHON}/" src/qlphelper/streamfinder.cpp || die
}

src_install() {
	cmake_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	readme.gentoo_print_elog
	optfeature "twitch support" "net-misc/streamlink"
	optfeature "youtube support" "dev-python/protobuf-python net-misc/streamlink"
}
