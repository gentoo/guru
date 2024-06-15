# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 git-r3 toolchain-funcs

DESCRIPTION="Seamlessly manage your app's Ruby environment"
HOMEPAGE="https://github.com/rbenv/rbenv"
LICENSE="MIT"

SLOT=0
EGIT_REPO_URI="https://github.com/rbenv/rbenv.git"
EGIT_BRANCH=master
ECONF_SOURCE=src
RDEPEND="app-shells/bash"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" -C src
}

src_install() {
	exeinto /usr/libexec/rbenv
	doexe libexec/*
	dosym ../libexec/rbenv/rbenv /usr/bin/rbenv

	set -- rbenv.d/*
	if [[ $# -gt 0 && -e $1 ]]; then
		insinto /usr/lib/rbenv/hooks
		doins -r "$@"
	fi

	newbashcomp completions/rbenv.bash rbenv
	dodoc README.md
}

pkg_postinst() {
	elog "Run 'rbenv init' and follow printed instructions to setup shell integration of rbenv for the current user."
	elog "Also read README.md or visit ${HOMEPAGE}."
}
