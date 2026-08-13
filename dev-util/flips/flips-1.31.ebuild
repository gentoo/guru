# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs desktop xdg

DESCRIPTION="Patcher for IPS and BPS files"
HOMEPAGE="https://www.smwcentral.net/?p=section&a=details&id=11474"

SRC_URI="https://dl.smwcentral.net/11474/floating.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+divsuf +gtk +pgo"
RDEPEND="
	divsuf? ( dev-libs/libdivsufsort )
	gtk? (
		x11-libs/gtk+:3
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
	virtual/imagemagick-tools[png]
	virtual/pkgconfig
"

src_unpack() {
	__vecho ">>> Unpacking ${P}.zip to ${PWD}"
	unzip -q "${DISTDIR}/${P}.zip" src.zip || die
	mkdir "${P}" || die
	unzip -q -d "${P}" src.zip || die
}

src_configure() { :; }

src_compile() {
	local pkg_config="$(tc-getPKG_CONFIG)"
	local myemakeargs=(
		CXX="$(tc-getCXX)"
		CFLAGS="${CPPFLAGS} ${CXXFLAGS}"
		LFLAGS="${LDFLAGS}"
		GTKFLAGS="$("${pkg_config}" --cflags --libs gtk+-3.0)"

		TARGET=$(usex gtk gtk cli)
		DIVSUF=$(usex divsuf)
	)
	if use divsuf; then
		myemakeargs+=(
			DIVSUF_CFLAGS="-DUSE_DIVSUFSORT $("${pkg_config}" --cflags libdivsufsort)"
			DIVSUF_LFLAGS="$("${pkg_config}" --libs libdivsufsort)"
		)
	fi
	if ! use pgo; then
		emake "${myemakeargs[@]}"
	else
		# From make.sh
		emake "${myemakeargs[@]}" CFLAGS="${CXXFLAGS} -fprofile-generate"
		# Upstream is missing profiling data, use whatever's available
		einfo "Running tests ..."
		./profile/profile1.sh ./flips bps.ico ips.ico || die
		./profile/profile1.sh ./flips libbps.cpp libips.cpp || die
		rm flips || die
		emake "${myemakeargs[@]}" CFLAGS="${CXXFLAGS} -fprofile-use"
	fi

	magick flips.ico flips.png || die
}

src_install() {
	einstalldocs
	dobin flips

	# Using the category field from newer upstream
	make_desktop_entry flips flips flips 'GNOME;GTK;Utility;RevisionControl'
	newicon flips-2.png flips.png
}
