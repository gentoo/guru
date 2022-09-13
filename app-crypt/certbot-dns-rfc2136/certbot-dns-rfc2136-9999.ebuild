# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

PARENT_PN="${PN%-dns-rfc2136}"
PARENT_P="${PARENT_PN}-${PV}"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	EGIT_SUBMODULES=()
	EGIT_CHECKOUT_DIR="${WORKDIR}/${PARENT_PN}"
else
	SRC_URI="
		https://github.com/certbot/certbot/archive/v${PV}.tar.gz
			-> ${PARENT_P}.tar.gz
	"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="RFC 2136 DNS Authenticator plugin for Certbot (Let’s Encrypt client)"
HOMEPAGE="
	https://letsencrypt.org/
"

LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${PARENT_P}/${PN}"

RDEPEND="
	${PYTHON_DEPS}
	>=app-crypt/acme-${PV}[${PYTHON_USEDEP}]
	>=app-crypt/certbot-${PV}[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-3.0.9[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-5.4.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

PATCHES=(
)

python_prepare_all() {
	pushd "${WORKDIR}/${PARENT_P}" > /dev/null || die
	default
	popd > /dev/null || die

	distutils-r1_python_prepare_all
}
