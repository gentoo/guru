# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fish-like autosuggestions for zsh"
HOMEPAGE="https://github.com/zsh-users/zsh-autosuggestions"
SRC_URI="https://github.com/zsh-users/zsh-autosuggestions/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

DEPEND=">=app-shells/zsh-4.3.11"

RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/zsh/site-functions/"
	doins "${PN}.zsh"
}

pkg_postinst() {
	elog "In order to use ${CATEGORY}/${PN} add ". /usr/share/zsh/site-functions/zsh-autosuggestions.zsh" at the end of your ~/.zshrc (including the dot)"
}
