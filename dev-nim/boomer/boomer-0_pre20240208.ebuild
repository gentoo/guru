# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Zoomer application for Linux"
HOMEPAGE="https://github.com/tsoding/boomer"
EGIT_COMMIT="dfd4e1f5514e2a9d7c7a6429c1c0642c2021e792"
SRC_URI="https://github.com/tsoding/boomer/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"
DEPEND="
	dev-nim/x11
	dev-nim/opengl
	"

# FIXME: README references demo.gif, but Portage does not install the image.
