# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/idris-hackers/idris-mode.git"
else
	SRC_URI="https://github.com/idris-hackers/idris-mode/archive/refs/tags/${PV}.tar.gz"
	KEYWORDS="~amd64"
	S=""
fi

DESCRIPTION="Idris syntax highlighting, compiler-supported editing, and interactive REPL"
HOMEPAGE="https://github.com/idris-hackers/idris-mode"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="app-emacs/prop-menu"
BDEPEND="${RDEPEND}"

SITEFILE="50${PN}-gentoo.el"
