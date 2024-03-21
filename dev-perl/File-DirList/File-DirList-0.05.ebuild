# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_A="${PN}/${PN}-${PV}.tar.gz"
DIST_AUTHOR=TPABA

inherit perl-module

DESCRIPTION="provide a sorted list of directory content"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
DEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
