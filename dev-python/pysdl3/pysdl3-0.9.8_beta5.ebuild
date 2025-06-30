# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="A pure Python wrapper for SDL3"
HOMEPAGE="
	https://pypi.org/project/pysdl3/
	https://github.com/Aermoss/PySDL3
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"

RDEPEND="
	media-libs/libsdl3
	${DEPEND}
"

src_install() {
	distutils-r1_src_install

	cat - > 99pysdl3 <<EOF
SDL_DISABLE_METADATA=1
SDL_DOC_GENERATOR=0
SDL_BINARY_PATH=/usr/$(get_libdir)
EOF

	# Workaround for https://github.com/Aermoss/PySDL3/issues/27
	doenvd 99pysdl3
}

python_test() {
	SDL_DISABLE_METADATA=1 SDL_DOC_GENERATOR=0 SDL_BINARY_PATH="/usr/$(get_libdir)" \
		${EPYTHON} -c 'import tests' || die
}
