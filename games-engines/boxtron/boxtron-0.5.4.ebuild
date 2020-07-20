# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Steam Play compatibility tool to run DOS games using native Linux DOSBox"
HOMEPAGE="https://github.com/dreamer/boxtron/"
SRC_URI="https://github.com/dreamer/boxtron/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="
	sys-devel/make
	app-arch/tar"

RDEPEND="
	>=dev-lang/python-3.5.0
	>=games-emulation/dosbox-staging-0.75.0
	media-sound/fluid-soundfont
	media-sound/timidity++
	sys-fs/inotify-tools"

src_compile() { :; }

src_install() {
	sed -i '/README.md/d' Makefile || die "sed failed"
	emake DESTDIR="${D}" prefix=/usr install || die "died running emake"
	dodoc README.md
}
