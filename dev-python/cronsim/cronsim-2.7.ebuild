# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Cron expression parser and evaluator"
HOMEPAGE="
	https://github.com/cuu508/cronsim
	https://pypi.org/project/cronsim/
"
SRC_URI="https://github.com/cuu508/cronsim/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
