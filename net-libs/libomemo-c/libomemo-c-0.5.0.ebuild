# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="XMPP fork of Signal Protocol C Library supporting XEP-0384 OMEMO"
HOMEPAGE="https://github.com/dino/libomemo-c/"
SRC_URI="https://github.com/dino/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-3"
SLOT="0"
