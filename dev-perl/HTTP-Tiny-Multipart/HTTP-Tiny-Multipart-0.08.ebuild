# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=RENEEB

inherit perl-module

DESCRIPTION="Add post_multipart to HTTP::Tiny"
LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-HTTP-Tiny
	virtual/perl-MIME-Base64
"
DEPEND="
	${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
