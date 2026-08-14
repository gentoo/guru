# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_P="${PN}-v${PV}"

DESCRIPTION="Small utility to dump info about DRM devices"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/drm_info"
SRC_URI="https://gitlab.freedesktop.org/emersion/drm_info/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+pci"

DEPEND="
	dev-libs/json-c:=
	>=x11-libs/libdrm-2.4.134
	pci? ( sys-apps/pciutils )
"
RDEPEND="${DEPEND}"
BDEPEND="app-text/scdoc"

src_configure() {
	local emesonargs=(
		-Dman-pages=enabled # scdoc is no pandoc
		$(meson_feature pci libpci)
	)
	meson_src_configure
}
