# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Signify keys used by Haelwenn (lanodan) Monnier"
HOMEPAGE="https://distfiles.hacktivis.me/releases/signify/"
SRC_URI="https://distfiles.hacktivis.me/releases/signify/${PV}.pub -> ${P}.pub"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86"

src_install() {
	insinto /usr/share/signify-keys
	doins "${DISTDIR}/${P}.pub"
}
