# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-$(ver_cut 1-3)-b.$(ver_cut 5)+$(ver_cut 7)"

inherit build2

SRC_URI="https://pkg.cppget.org/1/beta/${PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="ODB compiler and the ODB system documentation"
HOMEPAGE="https://www.codesynthesis.com/products/odb/"
LICENSE="GPL-3"

SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="=dev-cpp/libcutl-1.11.0*"

BDEPEND="
	=dev-cpp/libstudxml-1.1.0*
	${RDEPEND}
"

S="${WORKDIR}/${MY_P}"
