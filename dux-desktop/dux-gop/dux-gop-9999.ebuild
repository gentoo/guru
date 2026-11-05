# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="API & CLI for System & Process Monitoring "
HOMEPAGE="https://github.com/duxlabs-dev/dux-gop"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/duxlabs-dev/dux-gop.git"
else
	SRC_URI="https://github.com/duxlabs-dev/${PN}/releases/download/v${PV}/dgop-${PV}.tar.gz"
	S="${WORKDIR}/dgop-${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.27.1"

PATCHES=("${FILESDIR}"/"${PN}-0.2.3-no-strip.patch")

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_configure() {
	sed -i "s/^VERSION=.*$/VERSION=\"${PV}\"/" "${S}/Makefile"

	default
}

src_install() {
	dobin "${S}/bin/dgop"
}
