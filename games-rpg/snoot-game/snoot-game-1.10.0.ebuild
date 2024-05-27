# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )
inherit python-single-r1 desktop wrapper

MY_PV="Patch10-KurwaBobr"

DESCRIPTION="Visual novel parody of Goodbye Volcano High"
HOMEPAGE="https://snootgame.xyz/en"
SRC_URI="https://snootgame.xyz/en/bin/SnootGame-${MY_PV}-linux.tar.bz2"

S="${WORKDIR}/SnootGame-${MY_PV}-linux/"

LICENSE="AGPL-3 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="strip"

RDEPEND="${PYTHON_DEPS} virtual/opengl"
BDEPEND="${RDEPEND}"

QA_PREBUILT="*"

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
