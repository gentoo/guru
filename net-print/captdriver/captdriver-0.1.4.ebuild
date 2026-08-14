# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_V="0.1.4-m5"
MY_P="${PN}-${MY_V}"

DESCRIPTION="Alternative driver for Canon CAPT printers"
HOMEPAGE="https://github.com/mounaiban/captdriver"
SRC_URI="https://github.com/mounaiban/captdriver/archive/refs/tags/${MY_V}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	net-print/cups
	net-print/cups-filters
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/automake
	dev-build/autoconf
"

src_prepare() {
	default
	eaclocal
	eautoconf
	eautomake --add-missing
}

src_configure() {
	default
	./configure || die "./configure failed"
}

src_compile() {
	default
	make
	ppdc -v -d . src/canon-lbp.drv
}

ppd_dir="/usr/share/ppd"

src_install() {
	cups-config --serverbin || die -q "cups-config --serverbin failed"
	insinto "$ppd_dir"
	doins *.ppd
	exeinto "$(cups-config --serverbin)/filter"
	doexe src/rastertocapt
	docinto
	dodoc *.md
}

pkg_postinst() {
	einfo "PPD files are installed into $ppd_dir"
	einfo "You may want to add some printers that use CAPT driver"
	einfo "    lpadmin -p 'LBP2900' -v usb://Canon/LBP2900?serial=<serial> -P $ppd_dir/Canon-LBP2900-3000.ppd -E"
	einfo "    lpadmin -p 'LBP3000' -v usb://Canon/LBP3000?serial=<serial> -P $ppd_dir/Canon-LBP2900-3000.ppd -E"
	einfo "    lpadmin -p 'LBP3010' -v usb://Canon/LBP3100?serial=<serial> -P $ppd_dir/Canon-LBP3010.ppd.ppd -E"
	einfo "You can find the <serial> with lpinfo -v command"
}

pkg_postrm() {
	ewarn "You may want to remove printers that depends on this package."
}
