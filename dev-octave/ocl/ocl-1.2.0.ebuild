# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit octaveforge

DESCRIPTION="OpenCL support for GNU Octave"
HOMEPAGE="https://octave.sourceforge.io/ocl/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=sci-mathematics/octave-4.2.0"
RDEPEND="${DEPEND}"
