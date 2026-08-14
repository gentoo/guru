# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

if [[ "${PV}" = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aearil/dustr.git"
else
	EGIT_COMMIT="3465a079e4c1e52f798675b913f6e79204b9f5cc"
	SRC_URI="https://github.com/aearil/dustr/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"
fi

DESCRIPTION="light and interactive tool your crops need"
HOMEPAGE="https://github.com/aearil/dustr"
LICENSE="MIT"
SLOT="0"

DEPEND="
	media-libs/libpng:=
	media-libs/libjpeg-turbo:=
	media-libs/libsdl2:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/dustr-0_p20221008-make-cflags-ldflags.patch"
)

src_compile() {
	tc-export CC

	default
}

src_install() {
	einstalldocs

	DESTDIR="${ED}" emake install PREFIX="/usr"
}
