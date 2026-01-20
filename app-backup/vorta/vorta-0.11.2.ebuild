# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 desktop xdg

DESCRIPTION="A GUI for Borg Backup"
HOMEPAGE="https://github.com/borgbase/vorta"
SRC_URI="https://github.com/borgbase/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="test"

DEPEND="
	x11-themes/hicolor-icon-theme
	$(python_gen_cond_dep '
		app-backup/borgbackup[${PYTHON_USEDEP}]
		dev-python/peewee[${PYTHON_USEDEP}]
		<dev-python/platformdirs-5.0.0[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/pyqt6[gui,widgets,${PYTHON_USEDEP}]
		dev-python/secretstorage[${PYTHON_USEDEP}]
	')
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	distutils-r1_src_install

	local PACKAGE_ID="com.borgbase.Vorta"

	insinto /usr/share/icons/hicolor/symbolic/apps
	doins package/icon-symbolic.svg
	mv "${ED}/usr/share/icons/hicolor/symbolic/apps/icon-symbolic.svg" \
		"${ED}/usr/share/icons/hicolor/symbolic/apps/${PACKAGE_ID}-symbolic.svg"

	insinto /usr/share/icons/hicolor/scalable/apps
	doins src/vorta/assets/icons/icon.svg
	mv "${ED}/usr/share/icons/hicolor/scalable/apps/icon.svg" \
		"${ED}/usr/share/icons/hicolor/scalable/apps/${PACKAGE_ID}.svg"

	insinto /usr/share/metainfo
	doins src/vorta/assets/metadata/${PACKAGE_ID}.appdata.xml

	domenu src/vorta/assets/metadata/${PACKAGE_ID}.desktop
}
