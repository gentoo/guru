# Copyright 2022-2024 Gentoo Authors
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

DEPEND="
	dev-libs/jose
	sys-fs/cryptsetup
	luks? (
		app-misc/jq
		dev-libs/libpwquality
		dev-libs/luksmeta
	)
	tpm? ( app-crypt/tpm2-tools )
"
RDEPEND="${DEPEND}"

PATCHES=(
	# Fix for systemd on Gentoo
	"${FILESDIR}/clevis-meson.patch"
)
