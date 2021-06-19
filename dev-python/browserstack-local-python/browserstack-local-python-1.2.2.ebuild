# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} pypy3 )

inherit distutils-r1

SRC_URI="https://github.com/browserstack/browserstack-local-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Python bindings for BrowserStack Local"
HOMEPAGE="https://github.com/browserstack/browserstack-local-python"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/psutil[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
