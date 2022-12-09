# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

MY_PN="eclipse"
MY_PV="2022-12"
SRC_BASE="https://www.eclipse.org/downloads/download.php?r=1&file=/technology/epp/downloads/release/${MY_PV}/R/eclipse-parallel-${MY_PV}-R-linux-gtk"

DESCRIPTION="Eclipse IDE for Scientific Computing (C, C++, Fortran)"
HOMEPAGE="https://www.eclipse.org/"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz )
	arm64? ( ${SRC_BASE}-aarch64.tar.gz )
"

S="${WORKDIR}/${MY_PN}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="mirror"

RDEPEND="
	|| (
		dev-java/openjdk:11 dev-java/openjdk:17
		dev-java/openjdk-bin:11 dev-java/openjdk-bin:17
		dev-java/openjdk-jre-bin:11
	)
	x11-libs/gtk+:3
"

QA_FLAGS_IGNORED=".*"

src_install() {
	insinto "/opt/${PN}"
	doins -r "${S}/."

	exeinto "/opt/${PN}"
	doexe "${S}/${MY_PN}"
	make_wrapper ${PN%-*} "/opt/${PN}/${MY_PN} -vm /opt/openjdk*/bin/java" "" "/opt/${PN}" "/opt/bin"

	doicon -s 48 plugins/org.eclipse.platform_4.26.0.v20221123-1800/eclipse48.png
	make_desktop_entry eclipse-parallel "Eclipse IDE Parallel ${MY_PV}" eclipse48 "Development;" || die "Failed making desktop entry!"
}
