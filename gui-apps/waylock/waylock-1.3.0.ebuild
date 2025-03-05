# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="Small screenlocker for Wayland compositors"
HOMEPAGE="https://codeberg.org/ifreund/waylock"
SRC_URI="
	https://codeberg.org/ifreund/waylock/releases/download/v${PV}/${P}.tar.gz
	https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz -> zig-wayland-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz -> zig-xkbcommon-0.2.0.tar.gz
"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+man pie test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/wayland
	sys-libs/pam
	x11-libs/libxkbcommon:=
"
DEPEND="${RDEPEND}"
EZIG_VISION="0.13*"
BDEPEND="
	|| ( =dev-lang/zig-${EZIG_VISION} =dev-lang/zig-bin-${EZIG_VISION} )
	dev-libs/wayland-protocols
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED="usr/bin/waylock"

# : refer to sys-fs/ncdu :
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	grep_version=$(echo ${EZIG_VISION} | sed -E 's/\./\\./g; s/\*/.*/g')
	EZIG=$(compgen -c | grep 'zig.*-'$grep_version | head -n 1) || die
}

ezig() {
	zig-set_EZIG
	edo "${EZIG}" "${@}"
}

src_prepare() {
	edo mkdir "${WORKDIR}"/deps/

	ezig fetch --global-cache-dir "${WORKDIR}"/deps/  "${DISTDIR}"/zig-wayland-0.2.0.tar.gz
	ezig fetch --global-cache-dir "${WORKDIR}"/deps/  "${DISTDIR}"/zig-xkbcommon-0.2.0.tar.gz
	default
}

src_compile() {
	local zigoptions=(
		--verbose
		--system "${WORKDIR}"/deps/p/
		-Doptimize=ReleaseSafe
		-Dman-pages=$(usex man true false)
		-Dpie=$(usex pie true false)
		${ZIG_FLAGS[@]}
	)

	DESTDIR="${T}" ezig build "${zigoptions[@]}" --prefix /usr || die
}

src_test() {
	ezig build test || die
}

src_install() {
	cp -r "${T}"/{etc,usr} "${ED}"/ || die

	dodoc README.md || die
}
