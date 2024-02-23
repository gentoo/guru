# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

DESCRIPTION="Minecraft launcher for community-made modpacks on the Technic Platform"
HOMEPAGE="https://www.technicpack.net/"
SRC_URI="
	https://launcher.technicpack.net/launcher${PV:0:1}/${PV:2}/TechnicLauncher.jar -> ${P}.jar
	https://www.technicpack.net/favicon.ico -> ${PN}.ico
"

KEYWORDS="~amd64 ~x86"
LICENSE="technic"
SLOT="0"

RESTRICT="bindist mirror"

BDEPEND="media-gfx/imagemagick[png]"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	cp "${DISTDIR}/${PN}.ico" "${S}" || die
}

src_compile() {
	convert ${PN}.ico ${PN}.png || die
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar" ${PN}.jar
	java-pkg_dolauncher ${PN} --jar ${PN}.jar --java_args "\${JAVA_OPTS}"

	newicon -s 16x16 ${PN}-0.png technic.png
	newicon -s 32x32 ${PN}-1.png technic.png
	newicon -s 48x48 ${PN}-2.png technic.png
	make_desktop_entry ${PN} "Technic Launcher" technic Game
}
