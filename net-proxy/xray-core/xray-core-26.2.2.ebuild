# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="A unified platform for anti-censorship"
HOMEPAGE="https://github.com/XTLS/Xray-core/"

if [[ "${PV}" == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/XTLS/Xray-core.git"
else
	SRC_URI="
		https://github.com/XTLS/Xray-core/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/puleglot/Xray-core/releases/download/v${PV}/Xray-core-${PV}-vendor.tar.xz
"
	KEYWORDS="~amd64"
	S="${WORKDIR}/Xray-core-${PV}"
fi

# main
LICENSE="MPL-2.0"
# deps
LICENSE+=" Apache-2.0 BSD BSD-2 ISC LGPL-3 MIT"
SLOT="0"

RESTRICT="test"

RDEPEND="
	acct-user/xray
	acct-group/xray"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-lang/go-1.25.5:="

src_unpack() {
	if [[ "${PV}" == 9999* ]]; then
		git-r3_src_unpack
		pushd "${S}" || die
		# upstream bumped required go version to 1.25.6 for no particular reason
		# gvisor.dev/gvisor requires 1.25.5
		sed -E -i'' 's/^go 1\.25\..*/go 1.25.5/' go.mod || die
		ego mod tidy
		popd || die
		go-module_live_vendor
	else
		default
	fi
}

src_prepare() {
	# upstream bumped required go version to 1.25.6 for no particular reason
	# gvisor.dev/gvisor requires 1.25.5
	sed -E -i'' 's/^go 1\.25\..*/go 1.25.5/' go.mod || die
	default
}

src_compile() {
	if [[ ${PV} == 9999* ]]; then
		local CUSTOM_VER="$(git rev-parse --short HEAD)"
	else
		local CUSTOM_VER="${PV}"
	fi

	CGO_ENABLED=0 ego build -ldflags="-X github.com/xtls/xray-core/core.build=${CUSTOM_VER}" \
		-trimpath -o xray -v ./main
}

src_install() {
	default

	dobin xray
	systemd_dounit "${FILESDIR}"/xray.service
	systemd_newunit "${FILESDIR}"/xray_at.service "xray@.service"

	keepdir /etc/xray
}
