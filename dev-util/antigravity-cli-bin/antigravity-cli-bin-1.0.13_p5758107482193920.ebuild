# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_p/-}"

DESCRIPTION="Google's agentic development platform (CLI companion)"
HOMEPAGE="https://antigravity.google/"
SRC_URI="
	amd64? (
		https://storage.googleapis.com/antigravity-public/antigravity-cli/${MY_PV}/linux-x64/cli_linux_x64.tar.gz
			-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://storage.googleapis.com/antigravity-public/antigravity-cli/${MY_PV}/linux-arm/cli_linux_arm64.tar.gz
			-> ${P}-arm64.tar.gz
	)
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="bindist mirror strip"

QA_PREBUILT="usr/bin/agy"

src_install() {
	newbin antigravity agy
}
