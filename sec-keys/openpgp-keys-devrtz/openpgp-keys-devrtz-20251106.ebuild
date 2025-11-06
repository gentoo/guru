# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	'B9386554B7DD266BCB8E29A990F0C9B18A6B4A19:devrtz:openpgp,ubuntu'
)

inherit sec-keys

DESCRIPTION="OpenPGP keys used by Evangelos Ribeiro Tzaras"
HOMEPAGE="
	https://gitlab.gnome.org/devrtz
	https://salsa.debian.org/devrtz
"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
