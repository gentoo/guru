# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN=${PN/-/.}
DESCRIPTION="Alternate keyring backend implementations for use with the keyring package"
HOMEPAGE="
	https://github.com/jaraco/keyrings.alt
	https://pypi.org/project/keyrings.alt
"
SRC_URI="https://github.com/jaraco/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/keyring[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools_scm-3.4.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/rst-linker \
	dev-python/jaraco-packaging

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

S="${WORKDIR}/${MY_PN}-${PV}"
