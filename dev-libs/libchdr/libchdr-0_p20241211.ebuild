# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

HASH_CHDR=cb077337d53392454e7100a0fd07139ca678e527

DESCRIPTION="Standalone library for reading MAME's CHDv1-v5 formats"
HOMEPAGE="https://github.com/rtissera/libchdr/"
SRC_URI="https://github.com/rtissera/libchdr/archive/${HASH_CHDR}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${HASH_CHDR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=app-arch/zstd-1.5.6
	>=sys-libs/zlib-1.3.1

"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/0001-cmake-use-plain-pkg-config-to-discover-zlib-and-libz.patch
	"${FILESDIR}"/0002-cmake-disable-tests.patch
)
