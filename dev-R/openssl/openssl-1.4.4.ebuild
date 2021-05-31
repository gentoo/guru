# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Toolkit for Encryption, Signatures and certificates based on openssl'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="dev-R/askpass"
RDEPEND="
	${DEPEND}
	dev-libs/openssl
"
