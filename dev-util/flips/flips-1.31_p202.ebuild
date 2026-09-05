# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs xdg

DESCRIPTION="Patcher for IPS and BPS files"
HOMEPAGE="https://www.smwcentral.net/?p=section&a=details&id=11474"

MY_PV="${PV##*_p}"
SRC_URI="https://git.disroot.org/Sir_Walrus/Flips/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flips"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk +pgo"
RDEPEND="
	dev-libs/libdivsufsort
	gtk? (
		x11-libs/gtk+:3
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	# Unbundle divsuf
	sed -e '/^DIVSUF :=/{N;N;d}' \
		-i Makefile || die

	# Avoid traversing the filesystem to find a git repository
	sed -e '/^COMMIT_COUNT :=/s/:=.*$/:=/' \
		-i Makefile || die

	default
}

src_configure() { :; }

src_compile() {
	local pkg_config="$(tc-getPKG_CONFIG)"
	local DIVSUF_CFLAGS="$("${pkg_config}" --cflags libdivsufsort)"
	local DIVSUF_LIBS="$("${pkg_config}" --libs libdivsufsort)"
	local myemakeargs=(
		CXX="$(tc-getCXX)"
		PKG_CONFIG="$pkg_config"
		CFLAGS="${CPPFLAGS} ${DIVSUF_CFLAGS} ${CXXFLAGS}"
		LFLAGS="${LDFLAGS} ${DIVSUF_LIBS}"

		TARGET=$(usex gtk gtk cli)
	)
	if ! use pgo; then
		emake "${myemakeargs[@]}"
	else
		# From make-linux.sh
		emake "${myemakeargs[@]}" CFLAGS="${CXXFLAGS} -fprofile-generate"
		einfo "Running tests ..."
		./flips --create --bps-delta \
			profile/firefox-10.0esr.tar \
			profile/firefox-17.0esr.tar /dev/null || die
		./flips --create --bps-delta-moremem \
			profile/firefox-10.0esr.tar \
			profile/firefox-17.0esr.tar /dev/null || die
		rm flips || die
		emake "${myemakeargs[@]}" CFLAGS="${CXXFLAGS} -fprofile-use"
	fi
}

src_install() {
	einstalldocs

	if ! use gtk; then
		dobin flips
	else
		emake TARGET=gtk DESTDIR="${ED}" install
	fi
}
