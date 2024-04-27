# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="IP2Location C Library"
HOMEPAGE="https://github.com/chrislim2888/IP2Location-C-Library/"
SRC_URI="https://github.com/chrislim2888/IP2Location-C-Library/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/IP2Location-C-Library-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-lang/perl"

src_configure() {
	eautoreconf
	default
}

src_compile() {
	default
	pushd data > /dev/null || die
	perl ip-country.pl || die "Failed to generate database!"
	popd || die
}

src_install() {
	default
	find "${ED}" -type f -name '*.la' -delete || die
}
