# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OpenVR over OpenXR compatibility layer"
HOMEPAGE="https://gitlab.com/znixian/OpenOVR"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/znixian/OpenOVR.git"
	EGIT_BRANCH="openxr"
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3 Apache-2 MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/0001-Add-install-target.patch"
)

src_configure()
{
	# Installing to /usr would not work with Steam bacause pressure vessel
	# sandbox mounts /usr as /run/host/usr and openvr path would point to a
	# non-existing location.
	#
	# Pressure vessel would need to be fixed and patch the location
	# as it does for vulkan and other similar configuration files.
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/opt"
	)
	cmake_src_configure
}

src_install()
{
	cmake_src_install

	insinto /opt/OpenComposite
	doins "${FILESDIR}/openvrpaths.vrpath"
}

pkg_postinst()
{
	elog "For applications to use OpenComposite, symlink"
	elog "~/.config/openvr/openvrpaths.vrpath to /opt/OpenComposite/openvrpaths.vrpath."
}
