# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=TOMMY
DIST_EXAMPLES=( examples/load_a_file_into_a_variable.pl )
inherit perl-module

DESCRIPTION="Easy, versatile, portable file handling"

SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-perl/Module-Build
	dev-perl/Unicode-UTF8
	dev-perl/Test-NoWarnings
"

RDEPEND="
	virtual/perl-Exporter
"
