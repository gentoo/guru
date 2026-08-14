# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils

DESCRIPTION="A Nautilus extension that adds a context-entry for opening any terminal"
HOMEPAGE="https://github.com/Stunkymonkey/nautilus-open-any-terminal"
SRC_URI="https://github.com/Stunkymonkey/nautilus-open-any-terminal/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/nautilus-python
"
BDEPEND="
	sys-devel/gettext
"

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
