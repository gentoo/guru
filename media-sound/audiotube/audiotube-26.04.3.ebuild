# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

KFMIN="6.22.0"
QTMIN="6.10.1"

[[ ${PV} == 9999 ]] && GIT_ECLASS="git-r3"
inherit ecm gear.kde.org python-single-r1 ${GIT_ECLASS}

DESCRIPTION="KDE client for YouTube Music"
HOMEPAGE="https://apps.kde.org/audiotube/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://invent.kde.org/multimedia/${PN}.git"
	PROPERTIES="live"
else
	SRC_URI="mirror://kde/stable/release-service/${PV}/src/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="6"
IUSE="handbook test"
RESTRICT="!test? ( test )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/ytmusicapi[${PYTHON_USEDEP}]
	')
	>=dev-db/futuresql-0.1.1
	>=dev-libs/kirigami-addons-0.11.0:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtimageformats-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6[gstreamer]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/purpose-${KFMIN}:6
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-libs/qcoro-0.13.0
	$(python_gen_cond_dep '
		dev-python/pybind11[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${COMMON_DEPEND}
	media-plugins/gst-plugins-meta:1.0[http]
	net-misc/yt-dlp
"
BDEPEND="
	dev-build/cmake
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
"
pkg_setup() {
	python-single-r1_pkg_setup
}
