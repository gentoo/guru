# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=(python3_{10..12})
#DISTUTILS_USE_SETUPTOOLS=rdepend
DISTUTILS_USE_PEP517=setuptools

MYPN="certbot"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	inherit git-r3
	S=${WORKDIR}/${P}/${PN}
else
	SRC_URI="https://github.com/certbot/${MYPN}/archive/v${PV}.tar.gz -> ${MYPN}-${PV}.gh.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/certbot-${PV}/${PN}
fi

inherit distutils-r1

DESCRIPTION="Cloudflare DNS Authenticator plugin for Certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="${CDEPEND}
	>=app-crypt/certbot-${PV}[${PYTHON_USEDEP}]
	>=app-crypt/acme-${PV}[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	dev-python/dns-lexicon[${PYTHON_USEDEP}]
	dev-python/cloudflare[${PYTHON_USEDEP}]"
BDEPEND="test? ( ${RDEPEND} )"
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
