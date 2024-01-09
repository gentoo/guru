# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi shell-completion

DESCRIPTION="Personal advice utility for Gentoo package maintainers"
HOMEPAGE="
	https://find-work.sysrq.in/
	https://pypi.org/project/find-work/
"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<app-portage/gentoopm-2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-aliases[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]
	<dev-python/pydantic-3[${PYTHON_USEDEP}]
	>=dev-python/repology-client-0.0.2[${PYTHON_USEDEP}]
	<dev-python/repology-client-2[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/insipid-sphinx-theme \
	dev-python/sphinx-prompt

src_prepare() {
	distutils-r1_src_prepare
	mkdir completions || die
}

python_compile() {
	distutils-r1_python_compile

	local -x PATH="${BUILD_DIR}/install${EPREFIX}/usr/bin:${PATH}"
	local -x PYTHONPATH="${BUILD_DIR}/lib:${PYTHONPATH}"
	emake completions/find-work.{bash,zsh,fish}
}

src_install() {
	distutils-r1_src_install

	local mymakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}"/usr

		BASHCOMPDIR="$(get_bashcompdir)"
		ZSHCOMPDIR="$(get_zshcompdir)"
		FISHCOMPDIR="$(get_fishcompdir)"
	)

	emake "${mymakeargs[@]}" install-data
}
