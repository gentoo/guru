# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="A stub implementation providing the Mirage_random.C interface for testing"
HOMEPAGE="https://github.com/mirage/mirage-random-test"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/cstruct
	dev-ml/mirage-random
"
DEPEND="${RDEPEND}"
