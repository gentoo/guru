# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp

DESCRIPTION="On the fly syntax checking for GNU Emacs"
HOMEPAGE="https://www.flycheck.org/en/latest/"
SRC_URI="https://github.com/flycheck/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-emacs/dash"
RDEPEND="${BDEPEND}"

SITEFILE="50${PN}-gentoo.el"
DOCS="README.md"
