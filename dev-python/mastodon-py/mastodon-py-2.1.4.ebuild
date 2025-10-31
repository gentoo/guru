# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
PYPI_PN="Mastodon.py"
inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for the Mastodon API"
HOMEPAGE="
	https://pypi.org/project/Mastodon.py/
	https://github.com/halcy/Mastodon.py
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="blurhash crypt grapheme"

RDEPEND="
	>=dev-python/decorator-4.0.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4.2[${PYTHON_USEDEP}]
	blurhash? ( >=dev-python/blurhash-1.1.4[${PYTHON_USEDEP}] )
	crypt? (
		>=dev-python/cryptography-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/http-ece-1.0.5[${PYTHON_USEDEP}]
	)
	grapheme? (
		dev-python/grapheme[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	pytest-mock
	pytest-recording
	requests-mock
)
EPYTEST_XDIST=1
EPYTEST_DESELECT=(
	# passes only with outdated 'grapheme'
	tests/test_status_length.py::test_get_status_length_against_ground_truth
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

python_test() {
	epytest -o addopts=
}
