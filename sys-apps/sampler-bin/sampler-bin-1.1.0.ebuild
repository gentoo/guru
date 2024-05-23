# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="visualizer for shell commands, executions and alerting"
HOMEPAGE="https://sampler.dev"

SRC_URI="https://github.com/sqshq/sampler/releases/download/v1.1.0/sampler-1.1.0-linux-amd64 -> ${P}"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"

RDEPEND="media-libs/alsa-lib"

src_install() {
	newbin "${DISTDIR}"/${P} sampler-bin
}
