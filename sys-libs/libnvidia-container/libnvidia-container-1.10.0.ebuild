# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NVIDIA container runtime library"
HOMEPAGE="https://github.com/NVIDIA/libnvidia-container"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"
else
	SRC_URI="
		https://github.com/NVIDIA/${PN}/archive/v${PV/_rc/-rc.}.tar.gz -> ${P}.tar.gz
	"
	S="${WORKDIR}/${PN}-${PV/_rc/-rc.}"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE=""

RDEPEND="
	net-libs/libtirpc
	sys-libs/libcap
	sys-libs/libseccomp
	x11-drivers/nvidia-drivers
"

DEPEND="${RDEPEND}"

BDEPEND="
	net-libs/rpcsvc-proto
	sys-apps/lsb-release
	sys-devel/bmake
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.1.1-add-enum-h.patch
	"${FILESDIR}"/${PN}-1.1.1-add-sysfs-c.patch
	"${FILESDIR}"/${PN}-1.1.1-add-sysfs-h.patch
	"${FILESDIR}"/${PN}-1.1.1-add-utils-c.patch
	"${FILESDIR}"/${PN}-1.1.1-add-utils-h.patch
	"${FILESDIR}"/${PN}-1.7.0-fix-git.patch
	"${FILESDIR}"/${PN}-1.8.0-fix-makefile.patch
	"${FILESDIR}"/${PN}-1.1.1-fix-nvc.patch
	"${FILESDIR}"/${PN}-1.3.0-fix-nvc-info.patch
	"${FILESDIR}"/${PN}-1.3.0-fix-nvc-mount.patch
	"${FILESDIR}"/${PN}-1.3.0-fix-modprobe-utils-c.patch
	"${FILESDIR}"/${PN}-1.3.0-fix-modprobe-utils-h.patch
	"${FILESDIR}"/${PN}-1.8.0-fix-nvcgomk.patch
)
