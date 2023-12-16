# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module

DEPS_DATE="2023-12-16" # when the deps archive has been created

DESCRIPTION="A nonlinear 2D puzzle platformer taking place in impossible spaces"
HOMEPAGE="https://divverent.github.io/aaaaxy/"
SRC_URI="
	https://github.com/divVerent/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/41581401/packages/generic/${PN}/${PV}+${DEPS_DATE}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD MIT FTL OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/alsa-lib
	media-libs/libglvnd
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/advancecomp
	app-arch/zip
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXxf86vm
"

src_prepare() {
	eapply_user

	# some dependencies use -Werror
	find "${WORKDIR}" -type f -exec sed -i "s/\-Werror//g" {} + || die "Could not remove -Werror"
}

src_configure() {
	GOFLAGS+=" -buildmode=pie -trimpath -ldflags=-linkmode=external -mod=readonly -modcacherw"
}

src_compile() {
	emake AAAAXY_BUILD_USE_VERSION_FILE=true BUILDTYPE=release
}

src_install() {
	dobin ${PN}
	doicon -s scalable ${PN}.svg
	doicon -s 128 ${PN}.png
	domenu ${PN}.desktop
}
