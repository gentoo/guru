# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=poetry

VERIFY_SIG_METHOD="signify"
inherit distutils-r1 verify-sig

DESCRIPTION="Search Quassel logs for matching messages and print them"
HOMEPAGE="https://git.oriole.systems/quarg"
SRC_URI="
	https://git.oriole.systems/${PN}/snapshot/${P}.tar.gz
	verify-sig? (
		https://git.oriole.systems/${PN}/snapshot/${P}.tar.gz.asc
			-> ${P}.sha.sig
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="sqlite postgres"
RESTRICT="test"

DEPEND="${RDEPEND}"
RDEPEND="${PYTHON_DEPS}
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:0[${PYTHON_USEDEP}] )
	>=dev-python/sqlalchemy-2.0[${PYTHON_USEDEP},sqlite?]
"
BDEPEND="verify-sig? ( sec-keys/signify-keys-oriole-systems )"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/oriole-systems-20240330.pub"

src_unpack() {
	if use verify-sig; then
		cp "${DISTDIR}"/${P}.{sha.sig,tar.gz} "${WORKDIR}" || die
		verify-sig_verify_signed_checksums \
			${P}.sha.sig sha256 ${P}.tar.gz
	fi
	default
}

python_install_all() {
	default

	doman quarg.1
}
