# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="7375ba5bb0df87c68e58ad15e9e5e351ae020c08"

DESCRIPTION="A Multicast/Reduction Network"
HOMEPAGE="http://www.paradyn.org/mrnet"
SRC_URI="https://github.com/dyninst/mrnet/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="threadsafe" #launchmon libi slurm

DEPEND="dev-libs/boost:="
DEPEND="
	${RDEPEND}
"
#	slurm? ( sys-cluster/slurm )

#REQUIRED_USE="slurm? ( libi )"

src_prepare() {
	rm -r external || die
	default
}

src_configure() {
	local myconf=(
		--enable-shared
		--enable-verbosebuild
		--with-boost="${EPREFIX}/usr"

		$(use_enable threadsafe ltwt-threadsafe)
	)

#expat seems to be used only on cray
#	if use expat; then
#		myconf+=( "--with-expat=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-expat" )
#	fi
#	if use launchmon; then
#		myconf+=( "--with-launchmon=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-launchmon" )
#	fi
#	if use libi; then
#		myconf+=( "--with-libi=${EPREFIX}/usr" )
#		myconf+=( "--with-startup=libi" )
#		use slurm && myconf+=( "--with-libi-startup=slurm" )
#	else
#		myconf+=( "--without-libi" )
#		myconf+=( "--with-startup=ssh" )
#	fi

	econf "${myconf[@]}"
}

src_compile() {
	MAKEOPTS="-j1" emake
}

src_install() {
	dolib.so build/*/lib/*.so*
	dobin build/*/bin/*
	insinto /usr/include
	doins -r xplat/include/*
	doins -r include/mrnet*
	doheader build/*/*.h
	dodoc README ACKNOWLEDGMENTS
}
