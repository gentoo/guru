# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Utilities for Using Munsell Colours'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="dev-R/colorspace"
RDEPEND="${DEPEND}"
