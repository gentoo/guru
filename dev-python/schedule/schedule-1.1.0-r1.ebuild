# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#pypy3 fails tests
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python job scheduling for humans"
HOMEPAGE="https://github.com/dbader/schedule"

SRC_URI="https://github.com/dbader/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"

DEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/pygments

python_test() {
	epytest --deselect test_schedule.py::SchedulerTests::test_until_time
}
