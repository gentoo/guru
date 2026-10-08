# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN%%-bin}

DESCRIPTION="The open source coding agent"
HOMEPAGE="https://opencode.ai"

SRC_URI="
	amd64? (
		https://registry.npmjs.org/@opencode/cli-linux-x64-baseline/-/cli-linux-x64-baseline-${PV}.tgz -> ${P}-amd64.tar.gz
	)
	arm64? (
		https://registry.npmjs.org/@opencode/cli-linux-arm64/-/cli-linux-arm64-${PV}.tgz -> ${P}-arm64.tar.gz
	)
"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror strip"

QA_PREBUILT="usr/bin/opencode"

src_install() {
	dobin package/bin/${MY_PN}
	dosym ${MY_PN} /usr/bin/${MY_PN}2
}
