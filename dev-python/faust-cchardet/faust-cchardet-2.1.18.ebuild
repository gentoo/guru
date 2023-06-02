# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

GIT_SUBMODULES=(
	"PyYoshi uchardet bdb8a0376ddf5d3cab6397be0bad98dad106d77f src/ext/uchardet"
)
submodule_uris() {
	local g
	for g in "${GIT_SUBMODULES[@]}"; do
		g=(${g})
		echo "https://github.com/${g[0]}/${g[1]}/archive/${g[2]}.tar.gz -> ${g[1]}-${g[2]}.tar.gz"
	done
}

DESCRIPTION="universal character encoding detector"
HOMEPAGE="https://github.com/faust-streaming/cChardet"
SRC_URI="
	https://github.com/faust-streaming/cChardet/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(submodule_uris)
"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/cChardet-${PV}"

distutils_enable_tests pytest

src_unpack() {
	default

	local g
	for g in "${GIT_SUBMODULES[@]}"; do
		g=(${g})
		mv "${WORKDIR}/${g[1]}-${g[2]}"/* "${S}/${g[3]}" || die "could not move submodule ${g[2]}"
	done
}
