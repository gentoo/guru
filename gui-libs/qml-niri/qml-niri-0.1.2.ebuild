# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A QML plugin for niri"
HOMEPAGE="https://github.com/imiric/qml-niri"
SRC_URI="https://github.com/imiric/qml-niri/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="dev-build/just"

BUILD_DIR="${WORKDIR}/${P}/build"

src_install() {
	mkdir -p "${D}/usr/lib64/qt6/qml"
	cp -r build/Niri "${D}/usr/lib64/qt6/qml/"
}

scr_postinst() {
	elog "Make sure QML_IMPORT_PATH contains /usr/lib64/qt6/qml"
}
