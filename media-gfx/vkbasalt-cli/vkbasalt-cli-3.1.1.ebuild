# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Command-line utility for vkBasalt"
HOMEPAGE="https://gitlab.com/TheEvilSkeleton/vkbasalt-cli"
SRC_URI="https://gitlab.com/TheEvilSkeleton/vkbasalt-cli/-/archive/v${PV}/vkbasalt-cli-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-gfx/vkBasalt"

distutils_enable_tests import-check
