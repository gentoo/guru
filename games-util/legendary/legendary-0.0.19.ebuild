# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )

inherit distutils-r1

DESCRIPTION="A free and open-source replacement for the Epic Games Launcher"
HOMEPAGE="https://github.com/derrod/legendary"
SRC_URI="https://github.com/derrod/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/requests-3.0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
