# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MAX_KV_MAJ="5"
MAX_KV_MIN="8"
MODULES_OPTIONAL_USE="modules"
MODULES_OPTIONAL_USE_IUSE_DEFAULT=1
MY_REV="8700f281383a83b86d3bff5e46168eb24558b842"

inherit autotools linux-info linux-mod

DESCRIPTION="Linux Cross-Memory Attach"
HOMEPAGE="https://github.com/hjelmn/xpmem"
SRC_URI="https://github.com/hjelmn/xpmem/archive/${MY_REV}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${MY_REV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

MODULE_NAMES="xpmem(misc:${WORKDIR}/module/kernel:${WORKDIR}/module/kernel)"
BUILD_TARGETS="all"

pkg_pretend() {
	# https://github.com/hjelmn/xpmem/issues/43
	if use modules; then
		if kernel_is ge ${MAX_KV_MAJ} ${MAX_KV_MINOR}; then
			eerror "Unsupported kernel version"
			die
		fi
	fi
}

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
