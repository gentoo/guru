# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_COMMIT="e368dee27811d0c891677fa40609e197c64de58c"

inherit cmake

DESCRIPTION="Fast and Free Automatic Formatter for Verilog Source Code"
HOMEPAGE="https://github.com/thomasrussellmurphy/istyle-verilog-formatter"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thomasrussellmurphy/${PN}-verilog-formatter.git"
else
	SRC_URI="https://github.com/thomasrussellmurphy/${PN}-verilog-formatter/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}/${PN}-verilog-formatter-${MY_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
	)
	cmake_src_configure
}

DOCS=( README.md )

src_install() {
	dobin "${BUILD_DIR}/bin/istyle"
	einstalldocs
}
