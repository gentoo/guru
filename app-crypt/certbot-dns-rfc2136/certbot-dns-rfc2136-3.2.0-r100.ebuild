# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="RFC 2136 DNS Authenticator plugin for Certbot (Let’s Encrypt Client)"
HOMEPAGE="
	https://github.com/certbot/certbot
	https://pypi.org/project/certbot-dns-rfc2136/
	https://certbot-dns-rfc2136.readthedocs.io/en/stable/
	https://letsencrypt.org/
"

LICENSE="metapackage"
SLOT="0"

KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv"

# Meta package for transition
# No need to upgrade thanks to ">="
RDEPEND="
	>=app-crypt/certbot-${PV}-r100[certbot-dns-rfc2136]
"

pkg_postinst() {
	elog "This is a meta-package to help in transition to single package "
	elog "app-crypt/certbot."
	elog "It is advice to simply deselect this package and to emerge "
	elog "app-crypt/certbot[certbot-dns-rfc2136] for this module."
}
