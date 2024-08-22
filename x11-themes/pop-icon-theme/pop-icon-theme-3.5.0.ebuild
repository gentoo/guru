# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="System76 Pop icon theme for Linux"
HOMEPAGE="https://github.com/pop-os/icon-theme"
SRC_URI="https://github.com/pop-os/icon-theme/archive/v${PV}/${P}.tar.gz"
S="${WORKDIR}/icon-theme-${PV}"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
