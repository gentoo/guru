# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module unpacker

DESCRIPTION="A TUI bluetooth manager for Linux written in Go"
HOMEPAGE="https://darkhz.github.io/bluetuith"

# MAKE SURE to change these on every update
[[ ${PV} != 9999* ]] && \
GIT_COMMIT="dd21a9c"
GIT_DOCUMENTATION_COMMIT="3b2ebf5a6bc8a9ed2dc48e1fa7f0df5851ddb84b"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/darkhz/bluetuith.git"
else
	SRC_URI="https://github.com/darkhz/bluetuith/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/deps.tar.zst -> ${P}-deps.tar.zst"
	SRC_URI+=" https://github.com/darkhz/bluetuith/archive/${GIT_DOCUMENTATION_COMMIT}.tar.gz -> ${PN}-docs-${GIT_DOCUMENTATION_COMMIT}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

# main
LICENSE="Apache-2.0"
# deps
LICENSE+=" BSD-2 BSD MIT"
SLOT="0"

IUSE="doc"
RESTRICT="test"
RDEPEND="
	net-wireless/bluez
"
BDEPEND="
	$(unpacker_src_uri_depends)
"

src_unpack() {
	if [[ ${PV} == 9999* ]]; then
		# unpack code
		git-r3_src_unpack

		# unpack docs
		EGIT_BRANCH="documentation"
		git-r3_fetch
		EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}-${GIT_DOCUMENTATION_COMMIT}"
		git-r3_checkout

		go-module_live_vendor
	else
		unpacker_src_unpack
	fi
}

src_prepare() {
	[[ ${PV} != 9999* ]] && { ln -sv ../vendor ./ || die ; }
	default
}
src_compile() {
	# mimicking behavior from https://github.com/darkhz/bluetuith/blob/master/.goreleaser.yml
	[[ ${PV} == 9999* ]] && GIT_COMMIT=$(git rev-parse --short HEAD)
	ego build -ldflags "-X github.com/darkhz/bluetuith/cmd.Version=${PV}@${GIT_COMMIT}"
}

src_test() {
	ego test ./...
}

src_install() {
	default
	dobin "${PN}"
	dodoc -r ../"${PN}-${GIT_DOCUMENTATION_COMMIT}"/documentation/*.md
	use doc && docinto html && dodoc -r ../"${PN}-${GIT_DOCUMENTATION_COMMIT}"/docs/*
}
