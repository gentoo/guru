# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A daemon that connects to a Forgejo instance and runs jobs for CI"
HOMEPAGE="https://code.forgejo.org/forgejo/runner https://forgejo.org/docs/next/admin/actions/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://code.forgejo.org/forgejo/runner.git"
else
	SRC_URI="
		https://code.forgejo.org/forgejo/runner/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/gentoo-golang-dist/${PN}/releases/download/v${PV}/${P}-deps.tar.xz
	"
	S="${WORKDIR}/runner"

	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="examples"
RESTRICT="test"

DEPEND="
	>=dev-lang/go-1.24.0
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_compile() {
	# export version information
	# https://github.com/gentoo/guru/pull/205
	# https://forums.gentoo.org/viewtopic-p-8831646.html
	local VERSION
	if [[ "${PV}" == *9999* ]]; then
		VERSION="$(
			git describe --tags --first-parent --abbrev=7 --long --dirty --always \
			| sed -e "s/^v//g"
		)"
	else
		VERSION="${PVR}"
	fi

	local EXTRA_GOFLAGS_LD=(
		# "-w" # disable DWARF generation
		# "-s" # disable symbol table
		"-X=code.forgejo.org/forgejo/runner/v11/internal/pkg/ver.version=v${VERSION}"
	)

	GOFLAGS+=" '-ldflags=${EXTRA_GOFLAGS_LD[*]}'"

	ego build -tags 'netgo osusergo' -o forgejo-runner

	# Makefile does this
	# emake forgejo-runner
}

src_install() {
	dobin forgejo-runner

	systemd_dounit "contrib/forgejo-runner.service"

	dodoc "README.md"
	if use examples; then
		dodoc -r "examples"
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}
