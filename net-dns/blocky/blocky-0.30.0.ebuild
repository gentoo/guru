# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module systemd shell-completion

DESCRIPTION="Fast and lightweight DNS proxy as ad-blocker with many features written in Go"
HOMEPAGE="https://github.com/0xERR0R/blocky/"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/0xERR0R/blocky.git"
else
	SRC_URI="
	https://github.com/0xERR0R/blocky/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/deps.tar.xz -> ${P}-deps.tar.xz
"
	KEYWORDS="~amd64 ~arm64"
fi

# main
LICENSE="Apache-2.0"
# deps
LICENSE+=" AGPL-3 BSD-2 BSD ISC MIT MPL-2.0"
SLOT="0"

RESTRICT="test"

RDEPEND="
	acct-user/blocky
	acct-group/blocky
"

# PATCHES=(
# 	"${FILESDIR}"/disable-failed-tests-0.22.patch
# )

FILECAPS=(
	-m 755 'cap_net_bind_service=+ep' usr/bin/"${PN}"
)

src_unpack() {
	if [[ ${PV} == 9999* ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	[[ ${PV} != 9999* ]] && { export VERSION="${PV}" || die ; }

	# mimicking project's Dockerfile
	emake GO_SKIP_GENERATE=yes GO_BUILD_FLAGS="-tags static -v " build

	local shell
	for shell in bash fish zsh; do
		bin/"${PN}" completion "${shell}" > "${PN}"."${shell}" || die
	done
}

src_test() {
	# mimcking make test
	ego run github.com/onsi/ginkgo/v2/ginkgo --label-filter="!e2e" --coverprofile=coverage.txt --covermode=atomic \
		--cover -r -p
	ego tool cover -html coverage.txt -o coverage.html
}

src_install() {
	# primary program
	dobin bin/"${PN}"

	# secondary supplements
	insinto /etc/"${PN}"
	newins docs/config.yml config.yml.sample

	newbashcomp "${PN}".bash "${PN}"
	dofishcomp "${PN}".fish
	newzshcomp "${PN}".zsh _"${PN}"

	# TODO openrc services
	systemd_newunit "${FILESDIR}"/blocky-0.22.service "${PN}".service

	# docs
	einstalldocs
}
