# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Indexed filesystem search in GO"
HOMEPAGE="https://github.com/duxlabs-dev/dux-search"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/duxlabs-dev/dux-search.git"
else
	SRC_URI="https://github.com/duxlabs-dev/${PN}/releases/download/v${PV}/dsearch-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/dsearch-${PV}"

	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.27.1"

PATCHES=("${FILESDIR}"/"${PN}-0.3.2-no-strip.patch")

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	sed -i "s/^VERSION=.*$/VERSION=\"${PV}\"/" "${S}/Makefile" || die "Sed failed"
	sed -i 's/local\///' "${S}/assets/dsearch.service" || die "Sed failed"

	default
}

src_install() {
	dobin "${S}/bin/dsearch"
	systemd_douserunit "${S}/assets/dsearch.service"
}
