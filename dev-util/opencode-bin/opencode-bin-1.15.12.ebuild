# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The open source coding agent"
HOMEPAGE="https://opencode.ai"

SRC_URI="https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-x64.tar.gz -> ${P}-amd64.tar.gz"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

QA_PREBUILT="usr/bin/opencode"

src_install() {
	dobin opencode
}
