# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson verify-sig

DESCRIPTION="A daemon to provide haptic feedback on events (themes package)"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd-device-themes"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="
	verify-sig? (
		sec-keys/openpgp-keys-phosh
	)
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"
