# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULES_OPTIONAL_USE="modules"
MODULES_OPTIONAL_USE_IUSE_DEFAULT=1
MY_REV="242eaa1eca92567c2118afe21e37cafc524f9166"

inherit autotools linux-mod

DESCRIPTION="Linux Cross-Memory Attach"
HOMEPAGE="https://github.com/hjelmn/xpmem"
SRC_URI="https://github.com/hjelmn/xpmem/archive/${MY_REV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_REV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

MODULE_NAMES="xpmem(misc:${WORKDIR}/module/kernel:${WORKDIR}/module/kernel)"
BUILD_TARGETS="all"

src_prepare() {
	default
	AT_M4DIR="m4" eautoreconf
	if use modules; then
		cp -r "${S}" "${WORKDIR}/module" || die
	fi
}

src_configure() {
	local myconf=(
		--disable-kernel-module
	)
	econf "${myconf[@]}"

	if use modules; then
		pushd "${WORKDIR}/module" || die
	        econf
		popd || die
	fi
}

src_compile() {
	default
	use modules && linux-mod_src_compile
}

src_install() {
	einstalldocs
	default
	use modules && linux-mod_src_install
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
