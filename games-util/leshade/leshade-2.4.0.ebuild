# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit meson python-single-r1

MY_PN="LeShade"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A ReShade manager for Linux"
HOMEPAGE="https://github.com/Ishidawg/LeShade"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Ishidawg/LeShade.git"
else
	SRC_URI="https://github.com/Ishidawg/LeShade/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pyside:6[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	default

	python_fix_shebang .

	#sed -i "s/^app_version: str = .*/app_version: str = \"${PV}\"/" main.py || die

	if [[ ${PV} == *9999 ]] ; then
		sed -i "s/^build_type: str = .*/build_type: str = \"Nightly\"/" main.py || die
	fi
}
