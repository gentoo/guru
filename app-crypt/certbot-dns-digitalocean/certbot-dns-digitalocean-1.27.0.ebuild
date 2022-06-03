# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

MY_PN="certbot"
DESCRIPTION="Digitalocean DNS Authenticator plugin for Certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.gh.tar.gz"
S="${WORKDIR}/certbot-${PV}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	~app-crypt/certbot-${PV}[${PYTHON_USEDEP}]
	>=dev-python/digitalocean-1.11[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

distutils_enable_tests pytest
