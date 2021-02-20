# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg-utils

DESCRIPTION="https://github.com/FreeTubeApp/FreeTube"
HOMEPAGE="https://freetubeapp.io/"
SRC_URI="https://github.com/FreeTubeApp/FreeTube/releases/download/v${PV}-beta/freetube_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_configure() {
	unpack_deb "${DISTDIR}"/freetube_"${PV}"_amd64.deb
}

src_install() {
	DESTDIR="${D}"
	insinto /opt
	doins -r "${WORKDIR}"/opt/*
	insinto /usr/share/applications/
	doins -r "${WORKDIR}"/usr/share/applications/*
	insinto /usr/share/icons/
	doins -r "${WORKDIR}"/usr/share/icons/*
	chmod 4755 "${D}"/opt/FreeTube/chrome-sandbox
	chmod +x  "${D}"/opt/FreeTube/freetube
	dosym "${EPREFIX}"/opt/FreeTube/freetube /usr/bin/freetube-bin
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
