# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 git-r3

DESCRIPTION="Animation engine for explanatory math videos"
HOMEPAGE="https://github.com/3b1b/manim https://pypi.org/project/manimgl/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/3b1b/manim.git"
else
	SRC_URI="https://github.com/3b1b/manim/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/manim-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-python/colour[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/isosurfaces[${PYTHON_USEDEP}]
	=dev-python/ManimPango-0.4*[${PYTHON_USEDEP}]
	dev-python/mapbox_earcut[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/moderngl[${PYTHON_USEDEP}]
	dev-python/moderngl-window[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pydub[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/screeninfo[${PYTHON_USEDEP}]
	dev-python/skia-pathops[${PYTHON_USEDEP}]
	>=dev-python/svgelements-1.8.1[${PYTHON_USEDEP}]
	dev-python/sympy[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/validators[${PYTHON_USEDEP}]
	app-text/texlive
	media-video/ffmpeg
	virtual/opengl
	x11-libs/pango
	$(python_gen_cond_dep '
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	' python3_{7..10})
"
# typing-extensions is needed for python < 3.11
# so, only python3.10 should work too (because of PYTHON_COMPAT)

BDEPEND="
	doc? (
		dev-python/furo[${PYTHON_USEDEP}]
		dev-python/jinja2-cli[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

python_compile_all() {
	use doc && emake -C "${S}/docs" man && mv "${S}/docs/build/man/manim.1" "${S}/docs/build/man/${PN}.1"
}

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		doman "${S}/docs/build/man/${PN}.1"
		docinto examples
		dodoc example_scenes.py
		dodoc docs/example.py
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
