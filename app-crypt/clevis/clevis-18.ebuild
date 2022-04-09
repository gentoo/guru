# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+luks +tpm"

DEPEND="luks? ( app-misc/jq )
	>=dev-libs/jose-8
	luks? ( dev-libs/libpwquality )
	luks? ( dev-libs/luksmeta )
	tpm? ( app-crypt/tpm2-tools )
	sys-fs/cryptsetup"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-dracut.patch"
)
