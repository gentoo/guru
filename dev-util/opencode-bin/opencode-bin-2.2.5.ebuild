# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

MY_PN=${PN%%-bin}

DESCRIPTION="The open source coding agent"
HOMEPAGE="https://opencode.ai"

SRC_URI="
	amd64? (
		https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-x64.tar.gz -> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-arm64.tar.gz -> ${P}-arm64.tar.gz
	)
"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="mirror strip"

QA_PREBUILT="usr/bin/opencode"

src_install() {
	dobin ${MY_PN}
	dosym ${MY_PN} /usr/bin/${MY_PN}2

	for shell in bash fish zsh; do
		${MY_PN} --completions ${shell} > "${MY_PN}.${shell}" || die
	done

	newbashcomp ${MY_PN}.bash ${MY_PN}
	dofishcomp ${MY_PN}.fish
	newzshcomp ${MY_PN}.zsh _${MY_PN}
}
