# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

MY_PV="0.$(ver_rs 1-2 '').0"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Matrix client written in Go"
HOMEPAGE="
	https://gomuks.app
	https://github.com/gomuks/gomuks
"
JOB_ID="101336"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sysrq-golang-dist/${PN}/releases/download/v${MY_PV}/${MY_P}-vendor.tar.xz
	https://mau.dev/${PN}/${PN}/-/jobs/${JOB_ID}/artifacts/download -> ${MY_P}-web-assets.zip
"
S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3+"
# Go dependency licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT MPL-2.0 OFL-1.1"
# npm dependency licenses
LICENSE+=" Apache-2.0 BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="heif"

DEPEND="
	dev-db/sqlite:3
	dev-libs/olm
	media-libs/libwebp:=
	heif? ( media-libs/libheif:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/go-1.25.0
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PN}-26.07-unbundle-libwebp.patch )

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	go-module_src_unpack
	mv "${WORKDIR}"/web/dist "${S}"/web || die
}

src_prepare() {
	default

	# unbundle libwebp
	rm vendor/go.mau.fi/webp/z_*.c || die
}

src_configure() {
	SUBPACKAGES=( archivemuks gomuks{,-terminal} )

	# https://github.com/mattn/go-sqlite3#linux
	# -tags libsqlite3: use system sqlite3 instead of bundled
	# -tags libheif: use system libheif instead of bundled heic
	GO_BUILD_TAGS="$(usex heif libheif noheif),libsqlite3"

	go-module_src_configure
}

src_compile() {
	local MAUTRIX_VERSION=$(awk '/maunium\.net\/go\/mautrix / { print $2 }' go.mod)
	local BUILD_TIME=$(date -Iseconds)
	local go_ldflags=(
		-X "go.mau.fi/gomuks/version.Tag=v${MY_PV}"
		-X "go.mau.fi/gomuks/version.Commit=unknown"
		-X "go.mau.fi/gomuks/version.BuildTime=${BUILD_TIME}"
		-X "maunium.net/go/mautrix.GoModVersion=${MAUTRIX_VERSION}"
	)

	local cmd
	for cmd in "${SUBPACKAGES[@]}"; do
		einfo "Compiling ${cmd}"
		ego build \
			-ldflags "${go_ldflags[*]}" \
			-tags "${GO_BUILD_TAGS}" \
			"./cmd/${cmd}"
	done
}

src_install() {
	dobin "${SUBPACKAGES[@]}"
	einstalldocs
	docinto html
	dodoc "${WORKDIR}"/rpc.html
}
