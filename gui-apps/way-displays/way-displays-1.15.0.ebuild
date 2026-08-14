# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Auto Manage Your Wayland Displays"
HOMEPAGE="https://github.com/alex-courtis/way-displays"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alex-courtis/way-displays.git"
else
	SRC_URI="https://github.com/alex-courtis/way-displays/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/wayland
	dev-cpp/yaml-cpp:=
	dev-libs/libinput:=
	virtual/libudev:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		PREFIX="${EPREFIX}/usr" \
		PREFIX_ETC="${EPREFIX}" \
		ROOT_ETC="${EPREFIX}/etc" \
		VERSION="${PV}"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		PREFIX_ETC="${EPREFIX}" \
		ROOT_ETC="${EPREFIX}/etc" \
		install
}
