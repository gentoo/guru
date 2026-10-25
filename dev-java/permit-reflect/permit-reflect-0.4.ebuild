# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

COMMIT="ae7fc51f0160f73cacd1b763a1edaca3d66afaff"
DESCRIPTION="Reflection utilities for Java modules"
HOMEPAGE="https://github.com/nqzero/permit-reflect"
SRC_URI="https://github.com/nqzero/permit-reflect/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-11:*"
RDEPEND=">=virtual/jre-1.8:*"

JAVA_SRC_DIR="src"
