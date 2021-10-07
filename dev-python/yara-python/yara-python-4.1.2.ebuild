# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#with pypy3 undefined symbol: PyDescr_NewGetSet
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="https://github.com/VirusTotal/yara-python"
SRC_URI="https://github.com/virustotal/yara-python/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	=app-forensics/yara-$(ver_cut 1-2)*
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.1.0-system-libyara.patch" )

distutils_enable_tests setup.py

compile_python() {
	distutils-r1_python_compile --dynamic-linking
}

src_compile() {
	python_foreach_impl compile_python
}
