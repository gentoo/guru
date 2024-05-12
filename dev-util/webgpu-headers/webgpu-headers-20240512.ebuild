# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="aef5e428a1fdab2ea770581ae7c95d8779984e0a"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/webgpu-native/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/webgpu-native/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${PN}-${COMMIT}
fi

DESCRIPTION="Webgpu Header files"
HOMEPAGE="https://github.com/webgpu-native/webgpu-headers"

LICENSE="BSD-3"
SLOT="0"

multilib_src_install() {
	insinto /usr/include/webgpu
	doins "${S}"/webgpu.h
	insinto /usr/share/licenses
	newins "${S}"/LICENSE ${PN}
}
