# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
NEED_EMACS=25.1

inherit elisp

DESCRIPTION="Soothing pastel theme for Emacs"
HOMEPAGE="https://github.com/catppuccin/emacs"

EGIT_REPO_URI="https://github.com/catppuccin/emacs.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"

BDEPENDS="app-emacs/autothemer"

SITEFILE="50${PN}-gentoo.el"
