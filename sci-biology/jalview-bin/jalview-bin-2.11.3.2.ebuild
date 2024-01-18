# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_WANT_TARGET=1.8

inherit desktop java-pkg-2

DESCRIPTION="Editor of multiple sequence alignments."
HOMEPAGE="https://www.jalview.org/"
SRC_URI="https://www.jalview.org/getdown/release/jalview-all-${PV}-j1.8.jar"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	cp -v "${DISTDIR}/${A}" . || die
	unzip -u ${A} images/jalview_logo-48.png || die
}

src_install() {
	java-pkg_newjar "jalview-all-${PV}-j1.8.jar"
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	newicon images/jalview_logo-48.png jalview_logo_48.png
	make_desktop_entry "${PN}" JalView jalview_logo_48 Science
}
