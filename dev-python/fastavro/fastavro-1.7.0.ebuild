# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Fast read/write of AVRO files"
HOMEPAGE="
	https://github.com/fastavro/fastavro
	https://pypi.org/project/fastavro/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
TEST_S="${S}_test"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/python-zstandard[${PYTHON_USEDEP}]
		dev-python/python-snappy[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# TypeError
	tests/test_fastavro.py::test_regular_vs_ordered_dict_record_typeerror
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_unpack() {
	default

	cp -a "${S}" "${TEST_S}" || die
	rm -r "${TEST_S}"/fastavro/* || die
	cp {"${S}","${TEST_S}"}/fastavro/__main__.py || die
}

python_test() {
	cd "${TEST_S}" || die
	epytest
}

pkg_postinst() {
	optfeature "lz4 support" dev-python/lz4
	optfeature "snappy support" dev-python/snappy
	optfeature "zstd support" dev-python/python-zstandard
}
