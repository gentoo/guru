# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

MY_PN="${PN%-cli}"

DESCRIPTION="A command-line tool for Stripe"
HOMEPAGE="https://docs.stripe.com/stripe-cli"
if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/stripe/stripe-cli"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/stripe/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	# possible depfiles link if used
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
fi

LICENSE="Apache-2.0"

# echo "# dependency licenses:"; printf 'LICENSES+=" '
# go-licenses report ./... 2>/dev/null | awk -F ',' '{ print $NF }' | sort --unique | tr '\n' ' '; echo '"'

# dependency licenses:
LICENSES+=" Apache-2.0 BSD-2-Clause BSD-3-Clause ISC MIT MPL-2.0 Unlicense "
SLOT="0"
IUSE="bash-completion zsh-completion"

BDEPEND=">=dev-lang/go-1.24.1"

src_compile() {
	CGO_ENABLED=0 ego build -o "bin/${MY_PN}" "cmd/stripe/main.go"
}

src_install() {
	dobin "bin/${MY_PN}"

	# disables telemetry
	doenvd "$FILESDIR/99$PN"

	if use bash-completion ; then
		"bin/${MY_PN}" completion --shell bash
		newbashcomp "${MY_PN}-completion.bash" "$MY_PN"
	fi
	if use zsh-completion ; then
		"bin/${MY_PN}" completion --shell zsh
		newzshcomp "${MY_PN}-completion.zsh" "_$MY_PN"
	fi
}
