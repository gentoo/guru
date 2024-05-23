# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-single-r1

DESCRIPTION="Steam Play compatibility tool to run DOS games using native Linux DOSBox"
HOMEPAGE="https://github.com/dreamer/boxtron/"
SRC_URI="https://github.com/dreamer/boxtron/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	dev-build/make
	app-arch/tar"

RDEPEND="
	${PYTHON_DEPS}
	>=games-emulation/dosbox-staging-0.75.0
	media-sound/fluid-soundfont
	media-sound/timidity++
	sys-fs/inotify-tools"

src_prepare() {
	default
	sed -i '/README.md/d' Makefile || die "sed failed"
}

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}" prefix=/usr install || die "died running emake"
	dodoc README.md
	python_fix_shebang "${D}"/usr/share/boxtron/run-dosbox
	python_fix_shebang "${D}"/usr/bin/install-gog-game
}
