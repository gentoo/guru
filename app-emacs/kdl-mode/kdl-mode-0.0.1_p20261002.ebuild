# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# upstream has no tags currently
# package name has version taken from kdl-mode.el header and commit date
COMMIT="e966ed4b53f8a72b88a016e61bcadec42f317e39"

NEED_EMACS="29.1"

inherit elisp

DESCRIPTION="Major mode for editing KDL files in Emacs"
HOMEPAGE="https://github.com/taquangtrung/emacs-kdl-mode"
SRC_URI="
	https://github.com/taquangtrung/emacs-kdl-mode/archive/${COMMIT}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/emacs-kdl-mode-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/tree-sitter-kdl
"

RESTRICT="test"

DOCS=( README.md )
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp_src_compile
	elisp-make-autoload-file
}
