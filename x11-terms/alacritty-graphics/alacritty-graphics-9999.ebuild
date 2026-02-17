# Copyright 2017-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VERSION="1.85.0"

inherit cargo desktop shell-completion eapi9-ver

DESCRIPTION="GPU-accelerated terminal emulator with sixel support"
HOMEPAGE="https://alacritty.org"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
else
	SRC_URI="https://github.com/ayosec/alacritty/archive/refs/tags/v${PV}-graphics.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
fi

S="${WORKDIR}/alacritty-${PV}-graphics"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-DFS-2016 Unicode-3.0
"

SLOT="0"

IUSE="+wayland X"
REQUIRED_USE="|| ( wayland X )"

RESTRICT="mirror"

DEPEND="
	media-libs/fontconfig:=
	media-libs/freetype:2
	x11-libs/libxkbcommon
	X? ( x11-libs/libxcb:= )
"

RDEPEND="${DEPEND}
	!x11-terms/alacritty
	media-libs/mesa[X?,wayland?]
	virtual/zlib
	sys-libs/ncurses:0
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXrandr
	)
"

BDEPEND="
	dev-build/cmake
	app-text/scdoc
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		EGIT_BRANCH=graphics
		EGIT_REPO_URI="https://github.com/ayosec/alacritty"
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev X x11)
		$(usev wayland)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	scdoc < ./extra/man/alacritty.1.scd > ./alacritty.1 || die
	scdoc < ./extra/man/alacritty.5.scd > ./alacritty.5 || die
	scdoc < ./extra/man/alacritty-msg.1.scd > ./alacritty-msg.1 || die
	scdoc < ./extra/man/alacritty-bindings.5.scd > ./alacritty-bindings.5 || die

	cd alacritty || die
	cargo_src_compile
}

src_test() {
	cd alacritty || die
	cargo_src_test
}

src_install() {
	cargo_src_install --path alacritty

	doman alacritty.{1,5} alacritty-msg.1 alacritty-bindings.5

	newbashcomp extra/completions/alacritty.bash alacritty

	dofishcomp extra/completions/alacritty.fish

	dozshcomp extra/completions/_alacritty

	domenu extra/linux/Alacritty.desktop
	newicon -s scalable extra/logo/compat/alacritty-term+scanlines.svg Alacritty.svg
	newicon -s 512 extra/logo/compat/alacritty-term+scanlines.png Alacritty.png
	newicon -s 64 extra/logo/compat/alacritty-term.png Alacritty.png

	insinto /usr/share/metainfo
	doins extra/linux/org.alacritty.Alacritty.appdata.xml

	insinto /usr/share/alacritty
	doins -r scripts

	local DOCS=(
		CHANGELOG.md
		README.md
	)
	einstalldocs
}

pkg_postinst() {
	if ver_replacing -ne "${PV}" ; then
		einfo "Configuration files for ${CATEGORY}/${PN}"
		einfo "in \$HOME often need to be updated after a version change"
		einfo ""
		einfo "For information on how to configure ${PN}, see the manpage:"
		einfo "man 5 alacritty"
	fi
}
