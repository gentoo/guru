# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A pretty system information tool written in POSIX sh"
HOMEPAGE="https://github.com/Un1q32/pfetch"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Un1q32/pfetch.git"
else
	SRC_URI="https://github.com/Un1q32/pfetch/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	dodoc README*
}
