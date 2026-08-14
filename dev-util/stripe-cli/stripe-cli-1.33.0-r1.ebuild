# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

MY_PN="${PN%-cli}"

DESCRIPTION="A command-line tool for Stripe"
HOMEPAGE="https://docs.stripe.com/stripe-cli"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/stripe/stripe-cli"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/stripe/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	# possible depfiles link if used
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
fi

LICENSE="Apache-2.0"
#gentoo-go-license stripe-cli-1.33.0.ebuild
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 Unlicense "

SLOT="0"

BDEPEND=">=dev-lang/go-1.24.1"

src_unpack() {
	if [[ "${PV}" == 9999 ]];then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	CGO_ENABLED=0 ego build -o "bin/${MY_PN}" "cmd/stripe/main.go"
}

src_install() {
	dobin "bin/${MY_PN}"

	# disables telemetry
	doenvd "${FILESDIR}/99${PN}"

	"bin/${MY_PN}" completion --shell bash
	newbashcomp "${MY_PN}-completion.bash" "${MY_PN}"
	"bin/${MY_PN}" completion --shell zsh
	newzshcomp "${MY_PN}-completion.zsh" "_${MY_PN}"
}
