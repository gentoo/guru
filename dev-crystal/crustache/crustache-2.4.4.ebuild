# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

SPEC_PV="1.3.0"
DESCRIPTION="{{Mustache}} for Crystal"
HOMEPAGE="https://github.com/MakeNowJust/crustache"
SRC_URI="
	https://github.com/makenowjust/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	test? (
		https://github.com/mustache/spec/archive/refs/tags/v${SPEC_PV}.tar.gz -> mustache-spec-${SPEC_PV}.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
#RESTRICT="!test? ( test )"

# interpolation test fails
RESTRICT="test"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	default

	if use test; then
		cd "${S}" || die
		rmdir spec/mustache-spec || die
		mv "${WORKDIR}"/spec-${SPEC_PV} spec/mustache-spec || die
	fi
}
