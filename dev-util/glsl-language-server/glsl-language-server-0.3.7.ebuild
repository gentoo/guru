# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Language server implementation for GLSL"
HOMEPAGE="https://github.com/billyb2/${PN}-gentoo"
SRC_URI="https://github.com/billyb2/${PN}-gentoo/archive/refs/tags/${PV}-g.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/glslang dev-cpp/cli11 dev-cpp/nlohmann_json dev-libs/libfmt"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/ninja"

S=${WORKDIR}/${PN}-gentoo-${PV}-g

src_install() {
	DESTDIR="${D}" ninja -C${S}/build install

}
