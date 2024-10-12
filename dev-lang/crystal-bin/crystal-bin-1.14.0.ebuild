# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"
BV="${PV}-1"
BV_AMD64="${BV}-linux-x86_64"

DESCRIPTION="The Crystal Programming Language"
HOMEPAGE="https://crystal-lang.org https://github.com/crystal-lang/crystal"
SRC_URI="
	amd64? ( https://github.com/${MY_PN}-lang/${MY_PN}/releases/download/${PV}/${MY_PN}-${BV_AMD64}.tar.gz )
	doc? ( https://github.com/${MY_PN}-lang/${MY_PN}/releases/download/${PV}/${MY_PN}-${PV}-docs.tar.gz )
"
S="${WORKDIR}/${MY_PN}-${BV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="doc"

# file collisions
RDEPEND="
	!dev-lang/crystal
	!dev-util/shards
	!games-mud/crystal
	!sci-chemistry/tinker
"

QA_PREBUILT="usr/bin/.*"

src_prepare() {
	default

	rm -r share/licenses || die
	gunzip share/man/*/*.gz || die
}

src_install() {
	dobin bin/*

	insinto /usr
	doins -r share

	insinto /usr/$(get_libdir)
	doins -r lib/crystal

	use doc && HTML_DOCS=( "${WORKDIR}"/${MY_PN}-${PV}-docs )
	einstalldocs
}
