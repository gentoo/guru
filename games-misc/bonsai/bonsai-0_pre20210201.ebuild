# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="5e6e6aa7f44e1a770d9c56687ad1b660c409de00"

DESCRIPTION="bonsai tree generator written in bash"
HOMEPAGE="https://gitlab.com/jallbrit/bonsai.sh"
SRC_URI="https://gitlab.com/jallbrit/bonsai.sh/-/archive/${COMMIT}/bonsai.sh-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}.sh-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	newbin bonsai.sh bonsai
	dodoc README.md
}
