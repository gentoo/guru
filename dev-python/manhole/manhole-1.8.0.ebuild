# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Debugging manhole for python application"
HOMEPAGE="
	https://github.com/ionelmc/python-manhole
	https://pypi.org/project/manhole
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-${PN}-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="test? (
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/process-tests[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'dev-python/eventlet[${PYTHON_USEDEP}]' python3.8 python3.9)
)"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

distutils_enable_tests --install pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

python_test() {
	epytest_args=(
		--deselect tests/test_manhole.py::test_non_daemon_connection
		--deselect tests/test_manhole.py::test_daemon_connection
		--deselect tests/test_manhole.py::test_uwsgi
		--deselect tests/test_manhole.py::test_fork_exec
		--deselect tests/test_manhole.py::test_connection_handler_exec[str]
		--deselect tests/test_manhole.py::test_connection_handler_exec[func]
		--deselect tests/test_manhole.py::test_environ_variable_activation
		--deselect tests/test_manhole.py::test_stderr_doesnt_deadlock
		--deselect tests/test_manhole_cli.py
	)

	epytest "${epytest_args[@]}"
}
