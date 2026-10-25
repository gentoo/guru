# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Properly format SD cards under Linux"
HOMEPAGE="https://github.com/profi200/sdFormatLinux/"

MY_PN=sdFormatLinux
SRC_URI="https://github.com/profi200/sdFormatLinux/archive/refs/tags/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/sdFormatLinux-0.2.0-unhardcode-compiler-flags.patch"
	"${FILESDIR}/sdFormatLinux-0.2.0-unhardcode-lsblk-path.patch"
)

src_compile() {
	emake TARGET=sdFormatLinux
}

src_install() {
	einstalldocs
	dobin sdFormatLinux
}
