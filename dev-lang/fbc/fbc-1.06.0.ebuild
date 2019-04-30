# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="FreeBASIC - A free/open source, multi-platform BASIC compiler."
HOMEPAGE="https://www.freebasic.net"
SRC_URI="https://github.com/freebasic/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/freebasic/${PN}/releases/download/${PV}/FreeBASIC-${PV}-source-bootstrap.tar.xz
	https://gist.github.com/vilhelmgray/08cebe0f22e303f7d5e6e5bc71e3d1f2/raw/710ba9ded1c7772f23fd68c08e02402f167d2c56/fbc-1.06.0-bootstrap-dist-linux-x86.patch
	https://gist.github.com/vilhelmgray/08cebe0f22e303f7d5e6e5bc71e3d1f2/raw/710ba9ded1c7772f23fd68c08e02402f167d2c56/fbc-1.06.0-bootstrap-dist-linux-x86_64.patch"

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

PATCHES="${FILESDIR}/${PV}/${PN}"

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
		eapply "${FILESDIR}/${PV}/bootstrap"
		eapply "${DISTDIR}/fbc-1.06.0-bootstrap-dist-linux-x86.patch"
		eapply "${DISTDIR}/fbc-1.06.0-bootstrap-dist-linux-x86_64.patch"
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

	# fbc automatically strips the executables it compiles; in order to avoid
	# creating striped executables, we override the fbc hardcoded linker "-s"
	# flag with our own; "--strip-debug" was chosen arbitrarily (without the
	# "-g" flag the executable should not have debug_info symbols anyway, so the
	# "--strip-debug" flag should be a safe option)
	local fblflags="-Wl --strip-debug "
	# fbc requires a space after the -Wl option
	fblflags+=${LDFLAGS//-Wl,/-Wl }

	# Build fbc
	emake CFLAGS="${CFLAGS} ${xcflags[*]}" FBC="${fbc}" FBCFLAGS="${fbcflags}" FBLFLAGS="${fblflags}"
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install
	einstalldocs
}
