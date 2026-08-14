# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="Language server for Odin Programming language"
HOMEPAGE="https://github.com/DanielGavin/ols"

MY_PV="${PV/./-}"
SRC_URI="https://github.com/DanielGavin/ols/archive/refs/tags/dev-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/ols-dev-${MY_PV}"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE="odinfmt"

# Tracks the same version of Odin compiler
RDEPEND="
	~dev-lang/odin-${PV}
"

BDEPEND="${RDEPEND}"

# Replace version string for static ebuild
src_prepare() {
	default_src_prepare
	sed -i "s/\(VERSION=\).*/\1dev-${MY_PV}/" "${S}/build.sh" || die
}
# No need to configure
src_configure() {
	default
}

src_compile() {
	edo "${S}/build.sh"
	if use odinfmt; then
		edo "${S}/odinfmt.sh"
	fi
}

src_install() {
	dobin "${S}/ols"
	if use odinfmt; then
		dobin "${S}/odinfmt"
	fi
}
