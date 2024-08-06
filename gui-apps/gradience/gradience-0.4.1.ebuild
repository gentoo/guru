# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit meson python-single-r1 xdg

DESCRIPTION="Change the look of Adwaita with ease"
HOMEPAGE="https://gradienceteam.github.io/"
SRC_URI="https://github.com/GradienceTeam/Gradience/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="binchecks strip !test? ( test )"

DEPEND="
	dev-libs/glib:2
	>=gui-libs/gtk-4.5.0:4
	>=gui-libs/libadwaita-1.2:1
	>=net-libs/libsoup-3.2.0:3.0

	$(python_gen_cond_dep '
		dev-python/lxml[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.42.0:3[${PYTHON_USEDEP}]
	')
"

BDEPEND="
	>=dev-build/meson-0.4.0
	dev-util/blueprint-compiler

	test? (
		dev-util/desktop-file-utils
	)
"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/anyascii-0.3[${PYTHON_USEDEP}]
		dev-python/material-color-utilities[${PYTHON_USEDEP}]
		dev-python/reportlab[${PYTHON_USEDEP}]
		dev-python/svglib[${PYTHON_USEDEP}]
		dev-python/yapsy[${PYTHON_USEDEP}]
	')

	${DEPEND}
	${PYTHON_DEPS}
"

PATCHES=(
	"${FILESDIR}/${P}-fix-metainfo-path.patch"
	"${FILESDIR}/${PN}-0.3.0-appstream-test-ignore.patch"
)

DOCS=(
	CODE_OF_CONDUCT.md
	HACKING.md
	MAINTAINERS.md
	README.md
	ROADMAP.md
	SECURITY.md
)

src_install() {
	meson_src_install
	python_optimize
}
