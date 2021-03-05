# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A program to read and control device brightness"
HOMEPAGE="https://github.com/Hummer12007/brightnessctl"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Hummer12007/brightnessctl.git"
else
	SRC_URI="https://github.com/Hummer12007/brightnessctl/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="systemd udev"

DEPEND="
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
"
RDEPEND="${DEPEND}"
BDEPEND="
	systemd? ( virtual/pkgconfig )
"

src_compile() {
	use systemd && export ENABLE_SYSTEMD=1
	emake
}

src_install() {
	local myconf

	# Upstream does not install udev rules if systemd is enabled
	# Following this behaviour if both flags are enabled here
	if use systemd && use udev; then
		myconf="INSTALL_UDEV_RULES=0"
	elif use udev; then
		myconf="INSTALL_UDEV_RULES=1"
	else
		myconf="INSTALL_UDEV_RULES=0"
	fi

	emake install ${myconf} DESTDIR="${D}"
	dodoc README.md
}
