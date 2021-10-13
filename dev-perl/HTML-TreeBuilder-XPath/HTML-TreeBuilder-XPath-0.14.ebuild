# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=MIROD

inherit perl-module

DESCRIPTION="add XPath support to HTML::TreeBuilder"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND=""
	virtual/perl-ExtUtils-MakeMaker
DEPEND="
	${RDEPEND}
	dev-perl/XML-XPathEngine
	dev-perl/HTML-Tree
	test? ( dev-perl/Test-Pod )
"
