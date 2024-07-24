# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=poetry
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Advanced oscilloscope audio visualizer specializing in chiptune"
HOMEPAGE="
	https://pypi.org/project/corrscope/
	https://corrscope.github.io/corrscope/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/attrs[${PYTHON_USEDEP}]
		dev-python/appdirs[${PYTHON_USEDEP}]
		dev-python/atomicwrites[${PYTHON_USEDEP}]
		dev-python/colorspacious[${PYTHON_USEDEP}]
		dev-python/QtPy[${PYTHON_USEDEP}]
	')
	media-video/ffmpeg
"

PATCHES=(
	# appnope is a library for disabling powersaving on macOS. corrscope
	# hard-depends on this currently. appnope isn't packaged, and it seems a
	# bit silly to me to package it for gentoo given its purpose, so I've just
	# removed the few lines that import/invoke it.
	#
	# Ideally, we should upstream a fix that only conditionally imports it,
	# but I don't know how to do that right now.
	"${FILESDIR}"/remove-appnope-dep.patch

	# corrscope seems to have copied in a modified scipy file to their source
	# tree. That file uses np.deprecate, which is removed in numpy2. corrscope
	# doesn't care about this function being marked deprecated, so neither do we
	"${FILESDIR}"/remove-npdeprecate.patch
)
