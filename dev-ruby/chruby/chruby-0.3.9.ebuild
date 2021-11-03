# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Changes the current Ruby"
HOMEPAGE="https://github.com/postmodern/chruby"
SRC_URI="https://github.com/postmodern/chruby/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| ( >=app-shells/bash-3.0:* app-shells/zsh )"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install

	insinto "/etc/profile.d"
	newins "${FILESDIR}/systemwide.sh" "chruby.sh"
}
