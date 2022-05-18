# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://git.matrix.org/git/olm/about/"

inherit cmake-multilib

if [[ ${PV} != "9999" ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://gitlab.matrix.org/matrix-org/${PN}/-/archive/${PV}/${P}.tar.bz2"
else
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.matrix.org/matrix-org/${PN}.git"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
