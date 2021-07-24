# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Signal processing to select representative regions from Paraver traces"
HOMEPAGE="https://github.com/bsc-performance-tools/spectral"
SRC_URI="https://ftp.tools.bsc.es/spectral/spectral-${PV}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="extrae libbsctools openmp"

RDEPEND="
	sci-libs/fftw:3.0
	extrae? ( sys-cluster/extrae )
	libbsctools? ( sys-cluster/libbsctools )
"
DEPEND="${RDEPEND}"

#PATCHES=( "${FILESDIR}/respect-flags.patch" )

src_configure() {
	#https://github.com/bsc-performance-tools/spectral/issues/1
	append-cflags -fcommon
	append-cxxflags -fcommon

	local myconf=(
		--disable-static
		--enable-shared
		--with-fft="${EPREFIX}/usr"
		--with-pic

		$(use_enable openmp)
	)

	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi
	if use libbsctools; then
		myconf+=( "--with-libbsctools=${EPREFIX}/usr" )
	fi

	econf "${myconf[@]}" || die
}

src_install() {
	default
	dodoc ChangeLog README AUTHORS NEWS
}
