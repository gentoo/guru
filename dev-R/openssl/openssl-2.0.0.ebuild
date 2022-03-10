# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages toolchain-funcs

DESCRIPTION='Toolkit for Encryption, Signatures and certificates based on openssl'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="dev-R/askpass"
RDEPEND="
	${DEPEND}
	>=dev-libs/openssl-1.0.2
"

src_prepare() {
	tc-export AR
	R-packages_src_prepare
}

SUGGESTED_PACKAGES="
	dev-R/curl
	>=dev-R/testthat-2.1.0
	dev-R/digest
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/jsonlite
	dev-R/jose
	dev-R/sodium
"
