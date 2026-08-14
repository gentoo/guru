# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python m3u8 Parser for HTTP Live Streaming (HLS) Transmissions"
HOMEPAGE="
	https://github.com/globocom/m3u8
	https://pypi.org/project/m3u8/
"
SRC_URI="https://github.com/globocom/m3u8/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_DESELECT=(
	tests/test_loader.py::test_load_should_create_object_from_uri
	tests/test_loader.py::test_load_should_create_object_from_uri_with_relative_segments
	tests/test_loader.py::test_load_should_remember_redirect
	tests/test_loader.py::test_raise_timeout_exception_if_timeout_happens_when_loading_from_uri
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	dodoc LICENSE
}
