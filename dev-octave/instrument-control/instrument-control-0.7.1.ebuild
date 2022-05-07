# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="Low level I/O functions for serial, i2c and parallel interfaces"
HOMEPAGE="https://octave.sourceforge.io/instrument-control/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-3.8.0"
RDEPEND="${DEPEND}"
