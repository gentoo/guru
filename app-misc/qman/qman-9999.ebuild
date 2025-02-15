# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="A more modern manual page viewer for our terminals"
HOMEPAGE="https://github.com/plp13/qman"
EGIT_REPO_URI="https://github.com/plp13/qman.git"
EGIT_BRANCH="devel"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="+doc"

DEPEND="
	sys-libs/ncurses:=
	dev-libs/inih
	sys-libs/zlib
"
BDEPEND="
	dev-python/cogapp
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
		-Ddocdir="/usr/share/doc/${PF}"
	)
	meson_src_configure
}
