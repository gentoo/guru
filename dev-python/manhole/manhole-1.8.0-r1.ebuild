# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Debugging manhole for python application"
HOMEPAGE="
	https://github.com/ionelmc/python-manhole
	https://pypi.org/project/manhole/
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="
	test? (
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-py3doc-enhanced-theme

python_test() {
	local -x PYTHONPATH="${S}/src:${PYTHONPATH}"
	local EPYTEST_DESELECT=(
		tests/test_manhole.py::test_connection_handler_exec
		tests/test_manhole.py::test_non_daemon_connection
		tests/test_manhole.py::test_daemon_connection
		tests/test_manhole.py::test_environ_variable_activation
		tests/test_manhole.py::test_fork_exec
		tests/test_manhole.py::test_uwsgi
		tests/test_manhole_cli.py::test_help

		# usually passes but sometimes fails (bug #792225)
		tests/test_manhole.py::test_stderr_doesnt_deadlock
	)

	[[ ${EPYTHON} == pypy3 ]] && \
		EPYTEST_DESELECT+=( tests/test_manhole.py::test_log_fh )

	distutils-r1_python_test
}
