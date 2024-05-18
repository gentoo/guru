# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="light and interactive tool your crops need"
HOMEPAGE="https://github.com/aearil/dustr"
EGIT_REPO_URI="https://github.com/aearil/dustr.git"
LICENSE="MIT"
SLOT="0"

DEPEND="
	media-libs/libpng:=
	media-libs/libjpeg-turbo:=
	media-libs/libsdl2:=
"
RDEPEND="${DEPEND}"

src_install() {
	einstalldocs

	DESTDIR="${ED}" emake install PREFIX="/usr"
}
