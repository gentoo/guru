# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="OpenSSL Provider for TPM2 integration"

HOMEPAGE="https://github.com/tpm2-software/tpm2-openssl"
SRC_URI="https://github.com/tpm2-software/tpm2-openssl/releases/download/${PV}/${P}.tar.gz"
LICENSE="BSD"

SLOT="0/${PV}"
KEYWORDS="~amd64"

# Needs IBM's software TPM simulator, which isn't in Portage
RESTRICT="test"

RDEPEND=">=app-crypt/tpm2-tss-3.2.0:=
	=dev-libs/openssl-3.0*:0="

BDEPEND="sys-devel/autoconf-archive
	 virtual/pkgconfig"

src_prepare() {
	# See bug #833887 (and similar); eautoreconf means version information
	# could be incorrectly embedded

	sed -i \
	"s/m4_esyscmd_s(\[git describe --tags --always --dirty\])/${PV}/" \
	"${S}/configure.ac" || die
	eautoreconf
	default
}

src_install() {
	default
	find ${ED} -iname \*.la -delete || die

	# No libtool files are install, so nothing to check for bug #833887
}
