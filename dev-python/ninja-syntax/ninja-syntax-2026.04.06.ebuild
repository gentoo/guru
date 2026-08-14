# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..15} )

inherit python-r1

DESCRIPTION="Python module for generating .ninja files"
HOMEPAGE="https://github.com/ninja-build/ninja"
SRC_URI="https://raw.githubusercontent.com/ninja-build/ninja/9cabe6a3f3e69ea7ef3665c97e46d4f14433f7d8/misc/ninja_syntax.py -> ninja_syntax_${PV}.py"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="${RDEPEND}"

src_unpack() {
	mkdir -p "${S}" || die
	cp "${DISTDIR}/ninja_syntax_${PV}.py" "${S}/ninja_syntax.py" || die
}

src_install() {
	python_foreach_impl python_domodule ninja_syntax.py
}
