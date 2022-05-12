# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

DESCRIPTION="Command line client for https://exercism.io"
HOMEPAGE="https://exercism.org"
SRC_URI="https://github.com/${PN}/cli/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/Schievel1/gentoo-exercism/raw/main/${P}-deps.tar.xz"
LICENSE="MIT Apache-2.0 BSD-2 BSD MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-libs/glibc"
BDEPEND="dev-lang/go"

S="${WORKDIR}/cli-3.0.13"
go-module_set_globals

src_compile() {
	ego build -o out/exercism exercism/main.go
}

src_install() {
	default
	dobin out/exercism
	# bash-completion
	newbashcomp "shell/${PN}_completion.bash" "${PN}"
	# zsh-completion
	insinto /usr/share/zsh/site-functions
	newins "shell/${PN}_completion.zsh" "_${PN}"
}
