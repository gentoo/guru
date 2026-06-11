# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

KFMIN="6.22.0"
QTMIN="6.10.1"

[[ ${PV} == 9999 ]] && GIT_ECLASS="git-r3"
inherit ecm gear.kde.org python-single-r1 flag-o-matic ${GIT_ECLASS}

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

DEPEND="
	>=dev-db/futuresql-0.1.1
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=dev-libs/kirigami-addons-0.11.0:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/purpose-${KFMIN}:6
	net-misc/yt-dlp
	>=dev-qt/qtmultimedia-${QTMIN}:6[gstreamer]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtimageformats-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-libs/qcoro-0.13.0
	media-plugins/gst-plugins-meta:1.0[http]
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
"
DEPEND+=" $(python_gen_cond_dep '
	dev-python/ytmusicapi[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]
')"
RDEPEND+=" $(python_gen_cond_dep '
	dev-python/ytmusicapi[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]
')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	ecm_src_prepare
	# Making an on-the-fly patch
	if [[ -f src/CMakeLists.txt ]]; then
		sed -i '/target_link_libraries(ytm PUBLIC pybind11::embed)/a \set_target_properties(ytm PROPERTIES POSITION_INDEPENDENT_CODE ON)' src/CMakeLists.txt || die
		sed -i '/target_link_libraries(audiotube PRIVATE/a \    \${EXTRA_PYTHON_LIBS}' src/CMakeLists.txt || die
	fi
}

src_configure() {
	filter-lto
	append-cppflags "-I${EPREFIX}/usr/include/${EPYTHON}"
	local my_py_libs
	my_py_libs=$(python_get_LIBS)
	local mycmakeargs=(
		-DEXTRA_PYTHON_LIBS="${my_py_libs}"
	)
	ecm_src_configure
}
