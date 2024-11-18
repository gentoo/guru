# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} )

inherit lua-single toolchain-funcs xdg

pic_samples_commit=40738b358a5a5cb33d54897b008cbccad98e63d6
pic_samples_date=20201222

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://www.pulkomandy.tk/projects/GrafX2
	https://grafx2.eu/
"
SRC_URI="http://www.pulkomandy.tk/projects/GrafX2/downloads/${PN}-v${PV}.tar.gz
	test? (
		https://gitlab.com/GrafX2/pic-samples/-/archive/${pic_samples_commit}/pic-samples-${pic_samples_commit}.tar.bz2
		-> ${PN}-testdata-${pic_samples_date}.tar.bz2
	)
"
S="${WORKDIR}/${PN}-v$(ver_cut 1-2)/src"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc lua +sdl sdl2 ttf test"
REQUIRED_USE="
	lua? ( ${LUA_REQUIRED_USE} )
	?? ( sdl sdl2 )
	ttf? ( ^^ ( sdl sdl2 ) )
"
RESTRICT="!test? ( test )"

SDL_DEPS="
	media-libs/libsdl!VER!
	media-libs/sdl!VER!-image[tiff]
	ttf? ( media-libs/sdl!VER!-ttf )
"

RDEPEND="
	media-libs/libpng
	lua? ( ${LUA_DEPS} )
	sdl? ( ${SDL_DEPS//!VER!/} )
	sdl2? ( ${SDL_DEPS//!VER!/2} )
	!sdl? ( !sdl2? ( x11-libs/libX11 ) )
	ttf? ( media-libs/freetype )
"
DEPEND="$RDEPEND"

src_prepare() {
	pushd .. || die
	default

	if use test; then
		rmdir tests/pic-samples || die
		mv "${WORKDIR}/pic-samples-${pic_samples_commit}" tests/pic-samples || die
	fi

	popd || die

	# Remove optimisation and debug info from CFLAGS
	sed -r -i '/^\s*COPT\s*\+?=/s!\s*(-g(|gdb|stabs)|-O\$\(OPTIM\))(\s|$)!\3!g' Makefile
}

src_configure() {
	my_makeargs=(
		V=1
		PREFIX="${EPREFIX}/usr"
	)
	use sdl  && my_makeargs+=( API=sdl  )
	use sdl2 && my_makeargs+=( API=sdl2 )
	use sdl || use sdl2 || my_makeargs+=( API=x11  )

	use ttf || my_makeargs+=( NOTTF=1 )
	use lua || my_makeargs+=( NOLUA=1 SCRIPT_FILES="" )

	tc-export CC PKG_CONFIG
}

src_compile() {
	emake "${my_makeargs[@]}"
}

src_test() {
	emake "${my_makeargs[@]}" check
}

src_install() {
	emake "${my_makeargs[@]}" DESTDIR="${D}" install

	# install documentation
	cd ../doc || die
	dodoc README.txt COMPILING.txt

	if use doc; then
		dodoc -r original_docs

		insinto "/usr/share/doc/${P}"
		doins quickstart.rtf
	fi

	# grafx2 binary usually has name grafx2-sdl or grafx2-x11 but desktop file
	# references it as just grafx2, so let's create symlink to mitigate it.
	local bin="$(basename "$(ls "${ED}"/usr/bin/grafx2*)" )"
	[[ -z "$bin" ]] && die "failed to find installed binary"
	if [[ "$bin" != "grafx2" ]]; then
		echo "$bin"
		dosym "$bin" "/usr/bin/grafx2" || die;
	fi
}
