# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit multilib-minimal

MY_P="dxvk-${PV}"
DESCRIPTION="Vulkan-based implementation of D3D9, D3D10 and D3D11 for Linux / Wine"
HOMEPAGE="https://github.com/doitsujin/dxvk"
SRC_URI="https://github.com/doitsujin/dxvk/releases/download/v${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="video_cards_nvidia"

DEPEND=""
RDEPEND="
	|| (
		video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-440.31 )
		>=media-libs/mesa-20.2
	)
	|| (
		>=app-emulation/wine-staging-4.5[${MULTILIB_USEDEP},vulkan]
		>=app-emulation/wine-vanilla-4.5[${MULTILIB_USEDEP},vulkan]
	)
"

S="${WORKDIR}/${MY_P}"

# NOTE: Various repos contain dxvk ebuilds that install into …/dxvk.
# To not clash with them, this ebuild installs into …/dxvk-bin.

src_prepare() {
	default

	sed -i "s|^basedir=.*$|basedir=\"${EPREFIX}\"|" setup_dxvk.sh || die

	# Delete installation instructions for unused ABIs.
	if ! use abi_x86_64; then
		sed -i '/installFile "$win64_sys_path"/d' setup_dxvk.sh || die
	fi
	if ! use abi_x86_32; then
		sed -i '/installFile "$win32_sys_path"/d' setup_dxvk.sh || die
	fi

	fix_install_dir() {
		local bits="${MULTILIB_ABI_FLAG:8:2}"
		# Fix installation directory.
		sed -i "s|\"x${bits}\"|\"usr/$(get_libdir)/dxvk-bin\"|" \
			setup_dxvk.sh || die
	}
	multilib_foreach_abi fix_install_dir
}

multilib_src_install() {
	local bits="${MULTILIB_ABI_FLAG:8:2}"
	insinto "usr/$(get_libdir)/dxvk-bin"
	insopts --mode=755
	doins "${S}/x${bits}/"*.dll
}

multilib_src_install_all() {
	newbin setup_dxvk.sh setup_dxvk-bin.sh
}

pkg_postinst() {
	elog "dxvk-bin is installed, but not activated. You have to create DLL overrides"
	elog "in order to make use of it. To do so, set WINEPREFIX and execute"
	elog "setup_dxvk-bin.sh install --symlink."
}
