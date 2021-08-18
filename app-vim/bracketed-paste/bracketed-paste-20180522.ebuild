# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit readme.gentoo-r1 vim-plugin

COMMIT="c4c639f3cacd1b874ed6f5f196fac772e089c932"
DESCRIPTION="vim plugin: handles bracketed-paste-mode in vim (aka. automatic \`:set paste\`)"
HOMEPAGE="https://github.com/ConradIrwin/vim-bracketed-paste"
SRC_URI="https://github.com/ConradIrwin/vim-${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vim-${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

src_install() {
	vim-plugin_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	einfo
	readme.gentoo_print_elog
}
