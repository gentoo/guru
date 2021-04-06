# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop unpacker xdg

DESCRIPTION="https://github.com/FreeTubeApp/FreeTube"
HOMEPAGE="https://freetubeapp.io/"
SRC_URI="https://github.com/FreeTubeApp/FreeTube/releases/download/v${PV}-beta/freetube_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="/opt/FreeTube/*"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_configure() {
	unpack_deb "${DISTDIR}"/freetube_"${PV}"_amd64.deb
}

src_install() {
	DESTDIR="${D}"
	insinto /opt
	doins -r opt/*
	domenu usr/share/applications/freetube.desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/freetube.svg
	fperms 4755 /opt/FreeTube/chrome-sandbox || die
	fperms +x  /opt/FreeTube/freetube || die
	dosym ../../opt/FreeTube/freetube /usr/bin/freetube-bin
}
