# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3

DESCRIPTION="Language server for Odin Programming language"
HOMEPAGE="https://github.com/DanielGavin/ols"

EGIT_REPO_URI="${HOMEPAGE}.git"

#SRC_URI="${HOMEPAGE}/archive/refs/tags/dev-2026-01.tar.gz -> ${P}.tar.gz"

#S="${WORKDIR}/ols-dev-2026-01"

LICENSE="MIT"
SLOT="0"

#KEYWORDS="~amd64"
IUSE="odinfmt"

# Needs head of odin compiler
RDEPEND="
	~dev-lang/odin-9999
"

DEPEND="${RDEPEND}"

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

pkg_postinst() {
	elog "For more info on configuration, see ${HOMEPAGE}#configuration"
}
