# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Open source cross-platform UI framework written in Python"
HOMEPAGE="https://kivy.org/"
SRC_URI="
	https://github.com/kivy/kivy/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/kivy/kivy/commit/dcd8fb2a6ae3f96789d51e00e1ff2f3c2fc339ef.patch
		-> ${PN}-2.3.1-remove-all-the-compatibility-code-for-Python-2.x.patch
	https://github.com/kivy/kivy/commit/5a1b27d7d3bdee6cedb55440bfae9c4e66fb3c68.patch
		-> ${PN}-2.3.1-remove-old-Python-2-long-from-Cython-files.patch
	https://github.com/kivy/kivy/commit/4b20740cb63b03fdfb65b782f1ce3de42bd6e7b3.patch
		-> ${PN}-2.3.1-remove-Python-3.6-workaround.patch
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland X"

RDEPEND="
	dev-python/pysdl2[${PYTHON_USEDEP}]
	media-libs/libsdl2[wayland?,X?]
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf

	media-libs/gstreamer

	dev-python/filetype[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]

	test? (
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${DISTDIR}/${PN}-2.3.1-remove-all-the-compatibility-code-for-Python-2.x.patch"
	"${DISTDIR}/${PN}-2.3.1-remove-old-Python-2-long-from-Cython-files.patch"
	"${DISTDIR}/${PN}-2.3.1-remove-Python-3.6-workaround.patch"
	"${FILESDIR}/${PN}-2.3.1-fix-pytest-9.x.x-issues.patch"
)

EPYTEST_DESELECT+=(
	"kivy/tests/test_uix_textinput.py::TextInputGraphicTest::test_selectall_copy_paste"
)

EPYTEST_IGNORE=(
	"kivy/tests/test_audio.py"
	"kivy/tests/test_benchmark.py"
	"kivy/tests/test_clipboard.py"
	"kivy/tests/test_video.py"
)

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_compile() {
	use wayland && export USE_WAYLAND=1
	use X && export USE_X11=1
	distutils-r1_src_compile
}

python_test() {
	export nonetwork=1
	export NONETWORK=1
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	epytest -o addopts=
	rm results.png || die
}
