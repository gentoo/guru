# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature shell-completion

DESCRIPTION="cheat allows you to create and view interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

# licenses present in the final built
# software. Checked with dev-go/golicense
LICENSE="MIT Apache-2.0 BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="man"

RDEPEND="!<app-shells/zsh-completions-0.34.0"

src_compile() {
	ego build -o ${PN} ./cmd/${PN}
}

src_test() {
	ego test ./cmd/${PN}
}

src_install() {
	dobin ${PN}

	use man && doman doc/${PN}.1

	newbashcomp scripts/${PN}.bash ${PN}
	dofishcomp scripts/${PN}.fish

	newzshcomp scripts/${PN}.zsh _${PN}
}

pkg_postinst() {
	optfeature "fzf integration" app-shells/fzf
}
