# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-pkg-2 xdg

DESCRIPTION="An open-world game whose gameplay revolves around breaking and placing blocks"
HOMEPAGE="https://www.minecraft.net"
SRC_URI="https://launcher.mojang.com/v1/objects/eabbff5ff8e21250e33670924a0c5e38f47c840b/launcher.jar -> ${P}.jar
	https://launcher.mojang.com/download/minecraft-launcher.svg -> ${PN}-legacy.svg"

KEYWORDS="~amd64 ~x86"
LICENSE="Mojang"
SLOT="1"

RESTRICT="bindist mirror"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	true
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar" ${P}-legacy.jar
	java-pkg_dolauncher ${PN}-legacy --jar ${P}-legacy.jar --java_args "\${JAVA_OPTS}"

	doicon -s scalable "${DISTDIR}/${PN}-legacy.svg"
	make_desktop_entry ${PN}-legacy "Minecraft (legacy)" ${PN}-legacy Game
}
