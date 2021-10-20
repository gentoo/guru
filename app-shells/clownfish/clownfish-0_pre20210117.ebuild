# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="a0db28d8280d05561b8f48c0465480725feeca4c"

DESCRIPTION="fish shell mocks"
HOMEPAGE="https://github.com/IlanCosman/clownfish"
SRC_URI="https://github.com/IlanCosman/clownfish/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-shells/fish"

DOCS=( README.md )

src_install() {
	insinto "/usr/share/fish/vendor_functions.d"
	doins functions/*
	einstalldocs
}
