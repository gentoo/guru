# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="2194250ff2d50a37f92d4f82fac216729f4eba87"

DESCRIPTION="MD5 Algorithm"
HOMEPAGE="https://raku.land/github:cosimo/Digest::MD5"
SRC_URI="https://github.com/cosimo/perl6-digest-md5/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/perl6-digest-md5-${COMMIT}"
