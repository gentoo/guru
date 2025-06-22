# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-update"
	DEPEND="dev-lang/hare:="
else
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-update/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	DEPEND="~dev-lang/hare-$(ver_cut 1-3):="
fi

DESCRIPTION="assist in upgrading a codebase to a newer Hare release"
HOMEPAGE="https://sr.ht/~sircmpwn/hare-update"
LICENSE="EUPL-1.2"
SLOT="0"

# binaries are hare-built
QA_FLAGS_IGNORED="usr/bin/.*"

src_prepare() {
	default

	sed -i "s;^PREFIX=.*;PREFIX=${EPREFIX}/usr;" Makefile || die
}
