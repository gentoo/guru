# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Note: The package version is based on
# <https://flutter.googlesource.com/gallery-assets/+log/refs/heads/master/lib/fonts>
# To get a new package version, inspect element the
# "X days/months/years ago" text and get the title attribute in HTML.

EAPI=8

inherit font

COMMIT_HASH="43590e625ab1b07f6a5809287ce16f7e61d9e165"

DESCRIPTION="Current generation of Google’s brand typeface."
HOMEPAGE="https://fonts.google.com/specimen/Google+Sans"
SRC_URI="https://flutter.googlesource.com/gallery-assets/+archive/${COMMIT_HASH}/lib/fonts.tar.gz  -> ${P}.tar.gz"
S="${WORKDIR}"

LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

FONT_SUFFIX="ttf"
