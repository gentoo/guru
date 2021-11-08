# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Digitalocean DNS Authenticator plugin for Certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"
SRC_URI="https://github.com/certbot/certbot/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/certbot-${PV}/${PN}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	 =app-crypt/certbot-1.19.0-r0[${PYTHON_USEDEP}]
	 >=dev-python/digitalocean-1.11-r0[${PYTHON_USEDEP}]
	 dev-python/zope-interface[${PYTHON_USEDEP}]
"
