# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIM_PLUGIN_VIM_VERSION="7.1"
inherit vim-plugin

MY_PN=${PN%-style}
DESCRIPTION="vim plugin: indent code according to the OpenBSD and FreeBSD style(9)"
HOMEPAGE="https://wiki.freebsd.org/DevTools"
SRC_URI="https://cvsweb.openbsd.org/cgi-bin/cvsweb/~checkout~/ports/editors/vim/files/${MY_PN}.vim?rev=${PV} -> ${P}.vim"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86"

VIM_PLUGIN_HELPTEXT=\
"This plugin registers OpenBSD_Style() macro for changing a buffer's
indentation rules but does not change the indentation of existing code.

To activate it, simply type \\f in normal mode."

src_unpack() {
	mkdir -p "${S}"/syntax || die
	cp "${DISTDIR}"/${P}.vim "${S}"/syntax/${MY_PN}.vim || die
}
