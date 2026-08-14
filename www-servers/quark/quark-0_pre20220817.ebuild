# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="A small, GET-only static HTTP server"
HOMEPAGE="https://tools.suckless.org/quark/"
EGIT_REPO_URI="https://git.suckless.org/quark/"

if [[ ${PV} != *9999* ]]; then
	EGIT_COMMIT="5ad0df91757fbc577ffceeca633725e962da345d"
fi

LICENSE="ISC"
SLOT="0"

PATCHES=(
	"${FILESDIR}"/quark-9999-configure.patch
)

src_configure() {
	export CC=$(tc-getCC)
	export PREFIX="${EPREFIX}"/usr
}
