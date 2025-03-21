# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi shell-completion

DESCRIPTION="A pass extension for auditing your password repository. "
HOMEPAGE="https://github.com/roddhjav/pass-audit"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# Tests seems broken
RESTRICT="test"

DEPEND="app-admin/pass"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install

	newbashcomp share/bash-completion/completions/pass-audit "${PN}"
	newzshcomp share/zsh/site-functions/_pass-audit _"${PN}"
	doman share/man/man1/pass-audit.1

	exeinto /usr/lib/password-store/extensions
	doexe audit.bash
}
