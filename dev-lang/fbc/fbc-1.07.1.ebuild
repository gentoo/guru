# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A free/open source, multi-platform BASIC compiler."
HOMEPAGE="https://www.freebasic.net"
SRC_URI="https://github.com/freebasic/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/freebasic/${PN}/releases/download/${PV}/FreeBASIC-${PV}-source-bootstrap.tar.xz"

LICENSE="FDL-1.2 GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm libffi opengl X"

DEPEND="
	sys-libs/ncurses:=
	gpm? ( sys-libs/gpm )
	libffi? ( virtual/libffi )
	opengl? ( virtual/opengl )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXrandr
		x11-libs/libXrender
	)"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${PV}"

DOCS="${S}/doc/fbc.1"

BOOTSTRAP_S="${WORKDIR}/FreeBASIC-${PV}-source-bootstrap"

src_unpack() {
	# We only need bootstrap source code if fbc is not already present
	if ! has_version dev-lang/fbc; then
		unpack FreeBASIC-${PV}-source-bootstrap.tar.xz
	fi
	unpack ${P}.tar.gz
}

src_prepare() {
	# We only need bootstrap source code if fbc is not already present
	if ! has_version dev-lang/fbc; then
		cd "${BOOTSTRAP_S}" || die "cd failed"
		eapply "${FILESDIR}/${PV}"
		cd "${S}" || die "cd failed"
	fi
	default
}

src_compile() {
	local fbc="fbc"
	local fbcflags=""

	# We only need bootstrap compiler if fbc is not already present
	if ! has_version dev-lang/fbc; then
		cd "${BOOTSTRAP_S}" || die "cd failed"

		# Build bootstrap compiler
		emake bootstrap-minimal

		# Set bootstrap compiler to build fbc
		fbc="${BOOTSTRAP_S}/bin/fbc"
		fbcflags="-i ${BOOTSTRAP_S}/inc"

		cd "${S}" || die "cd failed"
	fi

	local xcflags=(
		$(usex gpm "" "-DDISABLE_GPM")
		$(usex libffi "" " -DDISABLE_FFI")
		$(usex opengl "" " -DDISABLE_OPENGL")
		$(usex X "" " -DDISABLE_X11")
	)

	# fbc requires a space after the -Wl option
	local fblflags=${LDFLAGS//-Wl,/-Wl }

	# Build fbc
	emake CFLAGS="${CFLAGS} ${xcflags[*]}" FBC="${fbc}" FBCFLAGS="${fbcflags}" FBLFLAGS="${fblflags}" TARGET=${CHOST}
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" TARGET=${CHOST} install
	einstalldocs
}
