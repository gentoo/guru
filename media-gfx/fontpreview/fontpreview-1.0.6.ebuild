# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Highly customizable and minimal font previewer written in bash"
HOMEPAGE="https://github.com/sdushantha/fontpreview"
SRC_URI="https://github.com/sdushantha/fontpreview/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-misc/xdotool
	app-shells/fzf
	virtual/imagemagick-tools
	media-gfx/sxiv
"

src_prepare() {
	sed -i 's#install:#install:\n\t@mkdir -p $(DESTDIR)$(BINDIR)#' Makefile \
		|| die "Patching the Makefile failed."

	default
}
