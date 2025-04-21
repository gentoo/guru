# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_PN="Mastodon.py"
inherit distutils-r1 optfeature pypi

DESCRIPTION="Python wrapper for the Mastodon API"
HOMEPAGE="
	https://pypi.org/project/Mastodon.py/
	https://github.com/halcy/Mastodon.py
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/blurhash-1.1.4[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.0.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/cryptography-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/http-ece-1.0.5[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-recording[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}"/${PN}-2.0.1-tests.patch )

EPYTEST_XDIST=1
EEPYTEST_DESELECT=(
	# something related to simplejson
	tests/test_notifications.py::test_notifications_dismiss_pre_2_9_2
	tests/test_status.py::test_status_card_pre_2_9_2
	# requires PROPERTIES="test_network"
	tests/test_streaming.py::test_stream_user_direct
	tests/test_streaming.py::test_stream_user_local
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

python_test() {
	epytest -o addopts=
}

pkg_postinst() {
	optfeature "webpush support" "dev-python/cryptography dev-python/http-ece"
}
