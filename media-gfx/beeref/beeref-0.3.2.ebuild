# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 desktop xdg

DESCRIPTION="A Simple Reference Image Viewer"

HOMEPAGE="https://beeref.org/"
SRC_URI="https://github.com/rbreu/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/PyQt6-6.6.1
	>=dev-python/rectangle-packer-2.0.2
	>=dev-python/exif-1.6.0
"

src_install() {
	distutils-r1_src_install

	newicon beeref/assets/logo.svg beeref.svg
	make_desktop_entry "beeref %f" "BeeRef" "beeref" \
		"Graphics" "MimeType=application/x-beeref"
}
