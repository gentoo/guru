# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop git-r3

DESCRIPTION="A basic launcher for Mupen64Plus"
HOMEPAGE="https://github.com/dh4/mupen64plus-qt"
EGIT_REPO_URI="https://github.com/dh4/mupen64plus-qt"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	>=dev-libs/quazip-1.5
	dev-qt/qtbase:6[gui,network,sql,widgets,xml]
"
DEPEND=">=games-emulation/mupen64plus-core-2.5
		${RDEPEND}"

src_prepare() {
	sed -i -e '/NO_UNSUPPORTED_PLATFORM_ERROR/aNO_PLUGINS' \
		CMakeLists.txt
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	# local fix for: qt_generate_deploy_app_script
	rm -rf "${D}"/usr/$(get_libdir)/ \
		"${D}"/usr/plugins/ \
		"${D}"/usr/lib64/qt6/plugins/ \
		"${D}"/usr/bin/qt.conf || die
	mkdir -p "${D}"/usr/share/qt6 || die
	mv "${D}"/usr/translations "${D}"/usr/share/qt6/ || die
	for i in "${D}"/usr/share/qt6/translations/*; do
		echo mv "${i}" "${i/qt_/mupen64plus-qt_}"
		mv "${i}" "${i/qt_/mupen64plus-qt_}" || die
	done
	doman resources/${PN}.6
	doicon resources/images/${PN}.png
	insinto /usr/share/applications
	doins resources/${PN}.desktop
}
