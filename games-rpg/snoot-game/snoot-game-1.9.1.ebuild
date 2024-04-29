# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )
inherit python-single-r1 desktop wrapper

DESCRIPTION="Visual novel parody of Goodbye Volcano High"
MY_PV="Patch9.1-RoastedLaika"
HOMEPAGE="https://snootgame.xyz/"
SRC_URI="https://snootgame.xyz/bin/SnootGame-${MY_PV}-linux.tar.bz2"

LICENSE="AGPL-3 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS} virtual/opengl"
BDEPEND="${RDEPEND}"

S="${WORKDIR}/SnootGame-${MY_PV}-linux/"

QA_PREBUILT="*"
RESTRICT+=" strip"

src_install() {
	local dir=/opt/${PN}
	insinto "${dir}"

	doins -r "${S}/."
	dodoc README.md

	fperms +x ${dir}/lib/py3-linux-x86_64/SnootGame
	fperms +x ${dir}/SnootGame.sh

	make_wrapper ${PN} "./SnootGame.sh" "${dir}" "${dir}"
	make_desktop_entry ${PN} "Snoot Game"
}
