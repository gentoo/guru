# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="An extensible music server written in Python."
HOMEPAGE="https://mopidy.com/"
SRC_URI="https://github.com/mopidy/mopidy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/gst-python[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-meta[mp3,ogg,flac]
	dev-python/pykka[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}

	test? (
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Upstream uses a mix of pytest and unittest
	# Since most tests are pytest, let's ignore unittest tests
	tests/http/test_server.py
	tests/http/test_handlers.py
)

EPYTEST_DESELECT=(
	# Broken test due to network-sandbox
	tests/stream/test_playback.py
	tests/test_help.py::HelpTest::test_help_has_mopidy_options
)
