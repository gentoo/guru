# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

COMMIT="c8f01b8b4aa8d8156a624405b8a4c646e3f6efaa"
DESCRIPTION="Fast and flexible CSV library that can read and write CSV data"
HOMEPAGE="https://github.com/ppvan/libcsv"
SRC_URI="https://github.com/ppvan/libcsv/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
