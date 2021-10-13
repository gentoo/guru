# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8,9} pypy3 )

inherit linux-info python-single-r1

DESCRIPTION="Dynamically edit AMD Ryzen processor P-States"
HOMEPAGE="https://github.com/r4m0n/ZenStates-Linux"
COMMIT=0bc27f4740e382f2a2896dc1dabfec1d0ac96818
SRC_URI="https://github.com/r4m0n/ZenStates-Linux/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="togglecode"
RDEPEND="
	${PYTHON_DEPS}
	togglecode? (
		$(python_gen_cond_dep '
			dev-python/portio[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DOCS=( README.md )
S="${WORKDIR}/${PN}-${COMMIT}"

CONFIG_CHECK="X86_MSR"

src_install() {
	newsbin zenstates.py zenstates
	python_fix_shebang "${ED}/usr/sbin/zenstates"
	if use togglecode ; then
		newsbin togglecode.py togglecode
		python_fix_shebang "${ED}/usr/sbin/togglecode"
	fi
	einstalldocs
}
