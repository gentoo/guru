# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN#athena-}"
DESCRIPTION="Common/helpful Spec compliant testing utilities"
HOMEPAGE="
	https://github.com/athena-framework/spec
	https://athenaframework.org/Spec
"
SRC_URI="https://github.com/athena-framework/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	mkdir -p .github/workflows || die
	touch .github/dependabot.yml || die
}
