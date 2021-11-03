# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	tests/test_fastavro.py::test_cython_python
	tests/test_main_cli.py::test_cli_record_output
	tests/test_main_cli.py::test_cli_stream_input
	tests/test_main_cli.py::test_cli_arg_metadata
	tests/test_main_cli.py::test_cli_arg_schema
	tests/test_main_cli.py::test_cli_arg_codecs
)
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Fast Avro for Python"
HOMEPAGE="
	https://github.com/fastavro/fastavro
	https://pypi.org/project/fastavro
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/snappy[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
	)
"

FASTAVRO_USE_CYTHON=1

distutils_enable_tests pytest
