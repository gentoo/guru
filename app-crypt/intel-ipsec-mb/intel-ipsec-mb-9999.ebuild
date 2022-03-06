# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

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

PATCHES=( "${FILESDIR}/intel-ipsec-mb-1.1_remove-werror-and-O3.patch" )

src_configure(){
	tc-export CC LD AR
}

src_compile() {
	local myconf=(
		SAFE_DATA=$(usex safe-data y n)
		SAFE_LOOKUP=$(usex safe-lookup y n)
		SAFE_PARAM=$(usex safe-param y n)
	)
	emake "${myconf[@]}" EXTRA_CFLAGS="${CFLAGS}"
}

src_install() {
	emake PREFIX="${ED}/usr" \
		NOLDCONFIG=y \
		LIB_INSTALL_DIR="${ED}/usr/$(get_libdir)" \
		MAN_DIR="${ED}/usr/share/man/man7" \
		install
}

src_test() {
	cd "${S}/test"
	LD_LIBRARY_PATH=../lib ./ipsec_MB_testapp -v
	LD_LIBRARY_PATH=../lib ./ipsec_xvalid_test -v
}
