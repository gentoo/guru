# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A lightweight, secure, and feature-rich Discord TUI client. "
HOMEPAGE="https://github.com/ayn2op/discordo"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ayn2op/${PN}.git"
else

	# use this only for 0pre_YYYYMMDD builds, otherwise, keep it empty.
	# needs to be changed if you're making a new 0pre_YYYYMMDD build
	GIT_COMMIT="32bb94f457685780251e5e0127f55411267b0b1a"

	# If another person updates it, be sure to change this line to your own depfile link
	SRC_URI="https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz "

	if [[ -n "${GIT_COMMIT}" ]]; then
		SRC_URI+="https://github.com/ayn2op/${PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${GIT_COMMIT}"
	else
		SRC_URI+="https://github.com/ayn2op/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	fi

	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"

# dependency licenses:
LICENSE+=" Apache-2.0 BSD-2 BSD GPL-3 ISC MIT "

SLOT="0"
BDEPEND="
	>=dev-lang/go-1.25.3
	x11-libs/libnotify
"

DOCS=( README.md internal/config/config.toml )

src_unpack() {
	if [[ "${PV}" == 9999 ]];then
		git-r3_src_unpack
		go-module_live_vendor
	else
		default
	fi
}

src_compile() {
	CGO_ENABLED=0 ego build -o "bin/${PN}"
}

src_install() {
	dobin "bin/${PN}"
	einstalldocs
}
