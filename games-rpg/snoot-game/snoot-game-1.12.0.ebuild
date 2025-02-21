# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit python-single-r1 desktop wrapper

MY_PV="Patch12-Monkeyborea"

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

src_prepare() {
	default

	MY_ARCH="$(uname -m)"

	# Remove executables for other architectures
	# (I tried using arrays but it was too much pain)
	case "$MY_ARCH" in
		aarch64)
			rm -r "lib/py3-linux-armv7l"
			rm -r "lib/py3-linux-x86_64"
			;;
		armv7l)
			rm -r "lib/py3-linux-aarch64"
			rm -r "lib/py3-linux-x86_64"
			;;
		x86_64)
			rm -r "lib/py3-linux-aarch64"
			rm -r "lib/py3-linux-armv7l"
			;;
		*)
			die "unsupported architecture: $MY_ARCH"
			;;
	esac
}

src_install() {
	local dir=/opt/${PN}
	insinto "${dir}"

	doins -r "${S}/."

	fperms +x ${dir}/lib/py3-linux-${MY_ARCH}/SnootGame
	fperms +x ${dir}/SnootGame.sh

	make_wrapper ${PN} "./SnootGame.sh" "${dir}" "${dir}"
	make_desktop_entry ${PN} "Snoot Game"
}
