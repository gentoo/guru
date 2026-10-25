# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Parser and printer for Android binary XML"
HOMEPAGE="https://code.google.com/archive/p/android4me/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.zip
	-> ${P}.zip"
S="${WORKDIR}/AXMLPrinter"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-11:*"
RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

JAVA_SRC_DIR="src"
