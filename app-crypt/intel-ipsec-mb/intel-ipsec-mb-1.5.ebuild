# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Multi-Buffer Crypto for IPSec from Intel"
HOMEPAGE="https://github.com/intel/intel-ipsec-mb"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/intel/intel-ipsec-mb.git"
else
	SRC_URI="https://github.com/intel/intel-ipsec-mb/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
IUSE="+safe-data +safe-lookup +safe-param test"
RESTRICT="!test? ( test )"

BDEPEND="
	>=dev-lang/nasm-2.13.03
"

src_configure(){
	local mycmakeargs=(
		-DSAFE_DATA=$(usex safe-data)
		-DSAFE_LOOKUP=$(usex safe-lookup)
		-DSAFE_PARAM=$(usex safe-param)
	)
	cmake_src_configure
}
