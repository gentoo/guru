# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="Open Source toolpath generator for 3D printers"
HOMEPAGE="https://slic3r.org"
if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/slic3r/${PN}"
	S="${WORKDIR}/slic3r-${PV}/xs"
else
	SRC_URI="https://github.com/slic3r/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/Slic3r-${PV}/xs"
fi
LICENSE="AGPL-3"
SLOT="0"

IUSE="+gui xs test"

RESTRICT="!test? ( test )"

BDEPEND="
	dev-lang/perl:=
	dev-perl/ExtUtils-CppGuess[${PERL_USEDEP}]
	dev-perl/ExtUtils-Typemaps-Default[${PERL_USEDEP}]
	dev-perl/ExtUtils-XSpp[${PERL_USEDEP}]
	dev-perl/Module-Build[${PERL_USEDEP}]
	dev-perl/Module-Build-WithXSpp[${PERL_USEDEP}]
	dev-perl/Devel-CheckLib[${PERL_USEDEP}]
	virtual/perl-ExtUtils-ParseXS
"

RDEPEND="
	dev-cpp/tbb
	dev-cpp/exprtk
	dev-lang/perl:=
	dev-libs/boost:=
	dev-libs/expat
	dev-libs/miniz:=
	dev-perl/Encode-Locale[${PERL_USEDEP}]
	dev-perl/Moo[${PERL_USEDEP}]
	gui-libs/gtk
	media-libs/admesh
	media-libs/freeglut
	net-misc/curl[openssl]
	virtual/perl-Encode
	virtual/perl-File-Spec
	virtual/perl-Scalar-List-Utils
	virtual/perl-Test-Simple
	virtual/perl-threads
	virtual/perl-Time-HiRes
	virtual/perl-autodie
	virtual/perl-parent
	virtual/perl-IO-Compress
	virtual/perl-Test-Harness
	virtual/perl-Test-Simple
	x11-libs/libXmu
	x11-libs/wxGTK
	gui? (
		>=dev-lang/perl-5.38.2-r3[perl_features_ithreads]
		dev-perl/Alien-wxWidgets[${PERL_USEDEP}]
		dev-perl/Class-Accessor[${PERL_USEDEP}]
		dev-perl/Growl-GNTP[${PERL_USEDEP}]
		dev-perl/libwww-perl[${PERL_USEDEP}]
		dev-perl/Net-Bonjour[${PERL_USEDEP}]
		dev-perl/OpenGL[${PERL_USEDEP}]
		dev-perl/Wx[${PERL_USEDEP}]
		dev-perl/Wx-GLCanvas[${PERL_USEDEP}]
		virtual/perl-Socket
	)
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/boost-io-context-${PV}.patch"
	"${FILESDIR}/build-with-system-libs-${PV}.patch"
)

src_prepare() {
	default
	local vendored=( admesh expat exprtk )
	for v in "${vendored[@]}"; do
		rm -rf src/"${v}" || die "Failed to remove vendored ${v}."
	done

	if [[ "${PV}" != *9999* ]]; then
		cd .. || die
		eapply "${FILESDIR}/cmake-with-system-libs.patch"
		sed -i "/^src\/admesh/d" xs/MANIFEST || die
	else
		sed -i "/^set(EXPAT_INCLUDES$/,/^)$/c\find_package(expat REQUIRED)\n" \
			../src/CMakeLists.txt || die

		rm -rf src/miniz || die "Failed to remove vendored miniz"
		sed -i "s|\"miniz/miniz.h\"|<miniz/miniz.h>|" src/Zip/ZipArchive.hpp || die
		sed -i "/^add_library(miniz STATIC$/,/^)$/c\find_package(miniz REQUIRED)\n" \
			../src/CMakeLists.txt || die
	fi
}

src_compile() {
	local myconf_str=""
	if use gui; then
		myconf_str+=" --gui"
	fi

	if use xs; then
		myconf_str+=" --xs"
	fi

	local myconf="$myconf_str"
	perl-module_src_compile
}

src_install() {
	perl-module_src_install

	cd .. || die
	exeinto /usr/libexec/slic3r
	doexe "slic3r.pl" || die

	insinto /usr/libexec/slic3r
	doins -r "lib" "var" "share" || die

	exeinto /usr/bin
	newexe - slic3r <<-EOF || die
		#!/bin/sh
		exec /usr/bin/perl -I/usr/libexec/slic3r/lib /usr/libexec/slic3r/slic3r.pl "\$@"
	EOF
}
