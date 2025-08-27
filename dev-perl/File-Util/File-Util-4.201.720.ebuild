# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=TOMMY
DIST_VERSION=4.201720
DIST_EXAMPLES=("examples/*")
inherit perl-module

DESCRIPTION="Easy, versatile, portable file handling"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-perl/Unicode-UTF8
	virtual/perl-Exporter
"
BDEPEND="
	dev-perl/Module-Build
	virtual/perl-ExtUtils-MakeMaker
	test? (
		${RDEPEND}
		dev-perl/Test-NoWarnings
	)
"
