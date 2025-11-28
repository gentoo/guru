# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion desktop xdg

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gokcehan/lf.git"
	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/gokcehan/${PN}/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
	# possible depfiles link if used
	SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
	S="${WORKDIR}/${PN}-r${PV}"
fi

LICENSE="MIT"

# echo "# dependency licenses:"; printf 'LICENSES+=" '
# go-licenses report ./... 2>/dev/null | awk -F ',' '{ print $NF }' | sort --unique | tr '\n' ' '; echo '"'

# dependency licenses:
LICENSES+=" Apache-2.0 BSD-3-Clause MIT "
SLOT="0"
IUSE="+static"

src_compile() {
	local ldflags="-w -X main.gVersion=r${PV}"
	use static && {
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	}

	ego build -ldflags="${ldflags}"
}

src_install() {
	local DOCS=( README.md etc/lfrc.example )

	dobin "${PN}"

	einstalldocs

	doman "${PN}.1"

	# bash & zsh cd script
	insinto "/usr/share/${PN}"
	doins "etc/${PN}cd.sh"

	# bash-completion
	newbashcomp "etc/${PN}.bash" "${PN}"
	bashcomp_alias lf lfcd

	# zsh-completion
	newzshcomp "etc/${PN}.zsh" "_${PN}"

	# fish-completion
	dofishcomp "etc/${PN}.fish"
	dofishcomp "etc/${PN}cd.fish"

	domenu "${PN}.desktop"
}
