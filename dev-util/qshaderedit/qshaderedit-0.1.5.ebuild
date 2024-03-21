# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Multiplatform shader editor inspired by Apple's OpenGL Shader Builder"
HOMEPAGE="https://gitlab.com/mazes_80/qshaderedit/"
SRC_URI="https://gitlab.com/mazes_80/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/glew:0
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog )
