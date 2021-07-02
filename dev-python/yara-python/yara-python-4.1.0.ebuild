# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1 eutils

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

distutils_enable_tests setup.py

compile_python() {
	distutils-r1_python_compile --dynamic-linking
}

src_compile() {
	python_foreach_impl compile_python
}
