# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a simple named pipe management utility"
HOMEPAGE="https://github.com/Ferdi265/pipectl"
SRC_URI="https://github.com/Ferdi265/pipectl/releases/download/v${PV}/pipectl-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

DEPEND="
	man? (
		app-text/scdoc
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_DOCUMENTATION=$(usex man)
		-DINSTALL_DOCUMENTATION=$(usex man)
	)

	cmake_src_configure
}
