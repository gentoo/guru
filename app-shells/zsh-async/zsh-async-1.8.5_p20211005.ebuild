# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1

MY_COMMIT="3ba6e2d1ea874bfb6badb8522ab86c1ae272923d"
DESCRIPTION="Run multiple asynchronous jobs with callbacks"
HOMEPAGE="https://github.com/mafredri/zsh-async"
SRC_URI="https://github.com/mafredri/zsh-async/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="app-shells/zsh"
BDEPEND="
	test? (
		app-shells/zsh
		dev-vcs/git
	)
"

RESTRICT="!test? ( test )"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/async.zsh
at the end of your ~/.zshrc"

src_test() {
	git init || die "git repository initialization for testing failed"
	./test.zsh -v || die "One or more tests failed"
}

src_install() {
	insinto /usr/share/zsh/site-functions
	doins async.zsh

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
