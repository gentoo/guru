# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DEBIAN_VERSION="${PV}-3"

DESCRIPTION="An anarchist FAQ"
HOMEPAGE="http://www.anarchistfaq.org/afaq/index.html"
SRC_URI="https://salsa.debian.org/debian/anarchism/-/archive/debian/${DEBIAN_VERSION}/anarchism-debian-${DEBIAN_VERSION}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-debian-${DEBIAN_VERSION}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	sed -Ei "s|file://(/usr/share/doc/)anarchism|file://${EPREFIX}\1${P}|" \
		debian/anarchism.desktop || die

	default
}

src_install() {
	dodoc -r html markdown README.md
	domenu debian/anarchism.desktop
	doicon debian/anarchism.svg
}

pkg_postinst() {
	elog "If you wish to symlink the index, the path is /usr/share/doc/anarchism-${PV}/html/index.html"
	elog "For example:"
	elog "ln -s /usr/share/doc/anarchism-${PV}/html/index.html ~/Desktop/Anarchist\\ FAQ.html"
}
