# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

PYPI_NO_NORMALIZE=1

inherit distutils-r1

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/loqusion/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/loqusion/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Hyprland shader configuration tool"
HOMEPAGE="https://github.com/loqusion/hyprshade"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/chevron
	dev-python/click
	gui-wm/hyprland
"

distutils_enable_tests pytest
