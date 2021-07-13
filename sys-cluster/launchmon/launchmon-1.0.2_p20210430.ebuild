# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="98ab769c53563f47c4319ce3c98ac394b4870bac"
MYPV="$(ver_cut 1-3)"

inherit autotools flag-o-matic

DESCRIPTION="software infrastructure that enables HPC run-time tools to co-locate tool daemons with a parallel job"
HOMEPAGE="https://github.com/LLNL/LaunchMON"
SRC_URI="https://github.com/LLNL/LaunchMON/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/LaunchMON-${COMMIT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+munge tracing-cost"

RDEPEND="
	dev-libs/boost:=
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	virtual/libelf

	munge? ( sys-auth/munge )
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -e "s|m4_esyscmd.*|${MYPV})|g" -i configure.ac || die
	eautoreconf
}

src_configure() {
	append-cxxflags "-std=c++14"
	local sec="none"
	use munge && sec="munge"
	local myconf=(
		--enable-shared
		--enable-sec-${sec}
		$(use_enable tracing-cost)
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	mv "${ED}/usr/etc" "${ED}" || die
}
