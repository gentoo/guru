# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake multibuild virtualx

DESCRIPTION="Library that bundles ForkAwesome for use within Qt applications"
HOMEPAGE="https://github.com/Martchus/qtforkawesome"

FORKAWESOME_PV=1.2.0
FORKAWESOME_P="Fork-Awesome-${FORKAWESOME_PV}"
SRC_URI="https://github.com/Martchus/qtforkawesome/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ForkAwesome/Fork-Awesome/archive/refs/tags/${FORKAWESOME_PV}.tar.gz -> ${FORKAWESOME_P}.tar.gz"

LICENSE="GPL-2"
LICENSE+=" MIT CC-BY-3.0 OFL-1.1"  # Fork-Awesome
SLOT="0/1"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	gui-libs/qtutilities[qt6(+)]
	dev-qt/qtdeclarative:6
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-perl/YAML-Tiny
"

pkg_setup() {
	MULTIBUILD_VARIANTS=( qt6 )
}

multibuild_src_configure() {
	local mycmakeargs=(
		-DCONFIGURATION_NAME="${MULTIBUILD_VARIANT}"
		-DCONFIGURATION_TARGET_SUFFIX="${MULTIBUILD_VARIANT}"
		-DCONFIGURATION_PACKAGE_SUFFIX_QTUTILITIES="-${MULTIBUILD_VARIANT}"
		-DFORK_AWESOME_FONT_FILE="${WORKDIR}/${FORKAWESOME_P}/fonts/forkawesome-webfont.woff2"
		-DFORK_AWESOME_ICON_DEFINITIONS="${WORKDIR}/${FORKAWESOME_P}/src/icons/icons.yml"
		-DEXCLUDE_TESTS_FROM_ALL=$(usex !test)
	)
	case "${MULTIBUILD_VARIANT}" in
		qt6) mycmakeargs+=( -DQT_PACKAGE_PREFIX=Qt6 ) ;;
	esac
	cmake_src_configure
}

src_configure() {
	multibuild_foreach_variant multibuild_src_configure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_test() {
	virtx multibuild_foreach_variant cmake_src_test
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
