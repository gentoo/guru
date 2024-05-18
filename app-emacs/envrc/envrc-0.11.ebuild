# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Emacs support for direnv which operates buffer-locally"
HOMEPAGE="https://github.com/purcell/envrc"
SRC_URI="https://github.com/purcell/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-emacs/inheritenv
"

SITEFILE="50${PN}-gentoo.el"
