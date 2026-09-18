# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1

DESCRIPTION="An extensible music server written in Python"
HOMEPAGE="https://mopidy.com/"
SRC_URI="https://github.com/mopidy/mopidy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/setuptools-scm"
# https://docs.mopidy.com/stable/installation/manual/
RDEPEND="
	dev-python/gst-python[${PYTHON_USEDEP}]
	dev-python/pykka[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-meta[mp3,ogg,flac]
	dev-libs/gobject-introspection
	x11-libs/cairo
"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/cyclopts[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/faker[${PYTHON_USEDEP}]
		dev-python/polyfactory[${PYTHON_USEDEP}]
		dev-python/dirty-equals[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( "${PN}" )
EPYTEST_LOAD_VIA_ENV=1

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Upstream uses a mix of pytest and unittest
	# Since most tests are pytest, let's ignore unittest tests
	tests/test_mixer.py
	tests/_app/test_deps.py
	tests/_app/test_extensions.py
	tests/_exts/http/test_server.py
	tests/_exts/http/test_handlers.py

	# these test depend on dev-python/httpx which has been deprecated
	tests/_exts/stream/test_http.py
	tests/_exts/stream/test_library.py
	tests/_exts/stream/test_playback.py
)

EPYTEST_DESELECT=(
	# Broken test due to network-sandbox
	tests/_exts/http/test_events.py
	tests/_exts/http/test_network.py
	tests/_exts/http/test_events.py

	# https://github.com/mopidy/mopidy/commit/784073e52af58c51a11ad89eeb793a72ecc01c92
	tests/_exts/m3u/test_translator.py::test_path_to_uri[test.mp3-file-file:///test.mp3]
)

src_prepare() {
	# remove deprecated license classifiers
	local class
	local classifiers=( "license =" "\"License ::" )
	for class in "${classifiers[@]}"; do
		sed -ie "/${class}/d" pyproject.toml
	done

	eapply_user
}

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
	distutils-r1_src_configure
}
