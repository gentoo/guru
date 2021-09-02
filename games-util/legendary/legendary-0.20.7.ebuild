# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS="bdepend"

inherit distutils-r1

DESCRIPTION="A free and open-source replacement for the Epic Games Launcher"
HOMEPAGE="https://github.com/derrod/legendary"
SRC_URI="https://github.com/derrod/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/legendary-0.20.7_Fix-missing-package.patch" )

RDEPEND="
	$(python_gen_cond_dep '
		<dev-python/requests-3.0[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
