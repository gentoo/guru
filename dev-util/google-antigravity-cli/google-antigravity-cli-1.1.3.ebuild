# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EXECUTION_ID="5723946948100096"

MY_PN="${PN#google-}"
DESCRIPTION="Command-line interface for Google's Antigravity agentic development platform"
HOMEPAGE="https://antigravity.google/"
BASE_URI="https://storage.googleapis.com/antigravity-public/antigravity-cli/${PV}-${EXECUTION_ID}"
SRC_URI="
	amd64? ( ${BASE_URI}/linux-x64/cli_linux_x64.tar.gz -> ${P}_amd64.tar.gz )
	arm64? ( ${BASE_URI}/linux-arm/cli_linux_arm64.tar.gz -> ${P}_arm64.tar.gz )
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror strip"

QA_PREBUILT="*"

src_install() {
	local agy_home="/opt/google/${MY_PN}"

	exeinto "${agy_home}"
	doexe "antigravity"
	dosym -r "${agy_home}/antigravity" "/usr/bin/agy"
}
