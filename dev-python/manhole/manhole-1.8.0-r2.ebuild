# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/sphinx-py3doc-enhanced-theme"
DOCS_DIR="docs"

inherit distutils-r1 docs

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

PATCHES=(
	"${FILESDIR}/importlib.patch"
)

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Need an internet connection
	tests/test_manhole.py::test_simple
	tests/test_manhole.py::test_connection_handler_exec
	tests/test_manhole.py::test_daemon_connection
	tests/test_manhole.py::test_non_daemon_connection
	tests/test_manhole.py::test_locals_after_fork
	tests/test_manhole.py::test_socket_path
	tests/test_manhole.py::test_with_fork
	tests/test_manhole.py::test_with_forkpty
	tests/test_manhole.py::test_oneshot_on_usr2_error

	# Need the python package signalfd
	tests/test_manhole.py::test_sigprocmask
	tests/test_manhole.py::test_sigprocmask_negative
	tests/test_manhole.py::test_sigmask

	# Usually passes but sometimes fails (bug #792225)
	tests/test_manhole.py::test_stderr_doesnt_deadlock

	# Cannot find a file or directory
	tests/test_manhole.py::test_uwsgi

	# Broken
	tests/test_manhole_cli.py::test_help
)

python_test() {
	[[ ${EPYTHON} == pypy3 ]] && \
		EPYTEST_DESELECT+=( tests/test_manhole.py::test_log_fh )
	distutils-r1_python_test
}
