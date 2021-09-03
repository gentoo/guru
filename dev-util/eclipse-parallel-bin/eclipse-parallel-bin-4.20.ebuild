# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

MY_PN="eclipse"
DESCRIPTION="Eclipse IDE for Scientific Computing (C, C++, Fortran)"
HOMEPAGE="https://www.eclipse.org/"
SRC_URI="
	amd64? ( https://download.eclipse.org/technology/epp/downloads/release/2021-06/R/eclipse-parallel-2021-06-R-linux-gtk-x86_64.tar.gz )
	arm64? ( https://download.eclipse.org/technology/epp/downloads/release/2021-06/R/eclipse-parallel-2021-06-R-linux-gtk-aarch64.tar.gz )
"

S="${WORKDIR}/${MY_PN}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""
RESTRICT="mirror"

RDEPEND="
	|| ( dev-java/openjdk:11 dev-java/openjdk-bin:11 dev-java/openjdk-jre-bin:11 dev-java/openjdk-sts-bin:15 )
	x11-libs/gtk+:3
"

src_install() {
	insinto "/opt/${PN}"
	doins -r "${S}/."

	exeinto "/opt/${PN}"
	doexe "${S}/${MY_PN}"
	make_wrapper ${PN%-*} "/opt/${PN}/${MY_PN} -vm /opt/openjdk*/bin/java" "" "/opt/${PN}" "/opt/bin"

	doicon -s 48 plugins/org.eclipse.platform_4.20.0.v20210611-1600/eclipse48.png
	make_desktop_entry eclipse-parallel "Eclipse IDE Parallel 2021-06" eclipse48 "Development;" || die "Failed making desktop entry!"
}
