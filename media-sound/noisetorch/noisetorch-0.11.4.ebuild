# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module desktop fcaps

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lawl/NoiseTorch"
else
	SRC_URI="https://github.com/lawl/NoiseTorch/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"

	S="${WORKDIR}/NoiseTorch-${PV}"
fi

DESCRIPTION="Real-time microphone noise suppression on Linux. "
HOMEPAGE="https://github.com/lawl/NoiseTorch"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

go-module_set_globals

src_prepare() {
	default
	eapply "${FILESDIR}/fix-make.patch"
}

src_install() {
	dobin "${S}/bin/noisetorch"
	domenu "${S}/assets/noisetorch.desktop"
	doicon "${S}/assets/icon/noisetorch.png"
}

pkg_postinst() {
	fcaps CAP_SYS_RESOURCE usr/bin/noisetorch
}
