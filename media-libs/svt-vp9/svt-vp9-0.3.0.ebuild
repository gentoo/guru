# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic cmake

DESCRIPTION="Scalable Video Technology for VP9 (SVT-VP9 Encoder)"
HOMEPAGE="https://github.com/OpenVisualCloud/SVT-VP9"

if [ ${PV} = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/OpenVisualCloud/SVT-VP9.git"
else
	SRC_URI="https://github.com/OpenVisualCloud/SVT-VP9/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~arm64"
	S="${WORKDIR}/SVT-VP9-${PV}"
fi

LICENSE="BSD-2-with-patent"
SLOT="0/1"

DEPEND="dev-lang/nasm"

src_prepare() {
	append-ldflags -Wl,-z,noexecstack
	cmake_src_prepare
}
