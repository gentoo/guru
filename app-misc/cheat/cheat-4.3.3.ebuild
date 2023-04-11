# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module optfeature

DESCRIPTION="cheat allows you to create and view interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

# licenses present in the final built
# software. Checked with dev-go/golicense
LICENSE="MIT Apache-2.0 BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="man zsh-completion"

RDEPEND="zsh-completion? ( !app-shells/zsh-completions )"
BDEPEND="man? ( app-text/pandoc )"

src_compile() {
	ego build -o ${PN} ./cmd/${PN}

	if use man; then
		pandoc -s -t man doc/${PN}.1.md -o doc/${PN}.1 || die "building manpage failed"
	fi
}

src_test() {
	ego test ./cmd/${PN}
}

src_install() {
	dobin ${PN}

	use man && doman doc/${PN}.1

	newbashcomp scripts/${PN}.bash ${PN}
	insinto /usr/share/fish/vendor_completions.d
	doins scripts/${PN}.fish

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins scripts/${PN}.zsh _cheat
	fi
}

pkg_postinst() {
	optfeature "fzf integration" app-shells/fzf
}
