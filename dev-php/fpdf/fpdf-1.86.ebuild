# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2034
EAPI=8

MY_PV="$(ver_rs 1 '')"
MY_P="${PN}${MY_PV}"

DESCRIPTION="FPDF is a PHP class which allows to generate PDF files with pure PHP"
HOMEPAGE="http://www.fpdf.org/"
SRC_URI="http://www.fpdf.org/en/dl.php?v=${MY_PV}&f=tgz -> ${MY_P}.tgz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT-fpdf"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="dev-lang/php:*[gd,zlib]"

DOCS=( install.txt )

src_install() {
	insinto "/usr/share/php/${PN}"
	doins -r ./*.php font/ makefont/

	if use doc; then
		docinto html
		dodoc -r changelog.htm fpdf.css FAQ.htm html/ tutorial/
	fi
}
