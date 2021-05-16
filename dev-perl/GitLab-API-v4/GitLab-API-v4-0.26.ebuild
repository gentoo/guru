# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=BLUEFEET

inherit perl-module

DESCRIPTION="A complete GitLab API v4 client"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND="
	dev-perl/Const-Fast
	dev-perl/HTTP-Tiny-Multipart
	dev-perl/JSON
	dev-perl/Log-Any
	dev-perl/Moo
	dev-perl/Path-Tiny
	dev-perl/Type-Tiny
	dev-perl/URI
	dev-perl/namespace-clean
	dev-perl/strictures
	virtual/perl-Carp
	virtual/perl-Exporter
	virtual/perl-Getopt-Long
	virtual/perl-HTTP-Tiny
"
DEPEND="
	${RDEPEND}
	test? (
		dev-perl/Test2-Suite
		virtual/perl-MIME-Base64
	)
"
BDEPEND="dev-perl/Module-Build-Tiny"
