# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ayatana Application Indicators Shared Library (GLib-2.0 reimplementation)"
HOMEPAGE="https://github.com/AyatanaIndicators/libayatana-appindicator-glib"

if [[ "${PV}" = "9999" ]]; then
EGIT_REPO_URI="https://github.com/AyatanaIndicators/libayatana-appindicator-glib"
inherit git-r3
else
SRC_URI="https://github.com/AyatanaIndicators/libayatana-appindicator-glib/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
fi

inherit cmake

LICENSE="GPL-3"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	sys-libs/glibc
	dev-libs/glib
	sys-devel/gcc
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	dev-util/gi-docgen
	dev-libs/gobject-introspection
	dev-lang/vala
	dev-libs/glib
"

src_prepare() {
	cmake_src_prepare
	cp -r "${FILESDIR}/cmake" "${S}" || die "cp failed"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test ON OFF)
		# -DENABLE_WERROR=OFF
		# -DENABLE_COVERAGE=OFF
		-DCMAKE_MODULE_PATH="${S}/cmake"
	)
	cmake_src_configure
}
