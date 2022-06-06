# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-$(ver_cut 1-3)-b.$(ver_cut 5)"

inherit build2

SRC_URI="https://pkg.cppget.org/1/beta/${PN}/${MY_P}.tar.gz"
DESCRIPTION="C++ utility library"
HOMEPAGE="https://www.codesynthesis.com/projects/libcutl/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"

S="${WORKDIR}/${MY_P}"
