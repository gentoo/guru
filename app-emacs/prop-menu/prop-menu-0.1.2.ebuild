# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp

DESCRIPTION="Compute pop-up menus from text and overlay properties "
HOMEPAGE="https://github.com/david-christiansen/prop-menu-el"
SRC_URI="https://github.com/david-christiansen/prop-menu-el/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/prop-menu-el-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	default
	rm Makefile || die
}

src_test() {
	${EMACS} ${EMACSFLAGS} ${BYTECOMPFLAGS} \
			 -l ert -l prop-menu-tests.el \
			 -f ert-run-tests-batch-and-exit || die "tests failed"
}

src_install() {
	elisp-install ${PN} prop-menu.{el,elc}
	elisp-site-file-install "${FILESDIR}"/${SITEFILE}
}
