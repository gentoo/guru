# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_PKGNAME="monero-${PV}"

SOURCE_NAME="monero-source-v${PV}"
SOURCE_ARCHIVE="${SOURCE_NAME}.tar.bz2"

DESCRIPTION="Monero developer keys"
HOMEPAGE="https://www.getmonero.org"
SRC_URI="
	https://downloads.getmonero.org/cli/source/${SOURCE_ARCHIVE}"
S="${WORKDIR}/${SOURCE_NAME}/utils/gpg_keys"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	insinto /usr/share/openpgp-keys/monero
	doins "${S}"/*
}
