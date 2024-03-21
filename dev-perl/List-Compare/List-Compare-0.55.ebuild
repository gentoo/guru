# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=JKEENAN

inherit perl-module

DESCRIPTION="Compare elements of two or more lists"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
DEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		dev-perl/Capture-Tiny
		dev-perl/IO-CaptureOutput
		>=virtual/perl-Test-Simple-0.100.0
	)
"
