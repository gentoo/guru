# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Combine joy-cons using hid-nintendo"
HOMEPAGE="https://github.com/DanielOgorchock/joycond"
EGIT_REPO_URI="https://github.com/DanielOgorchock/joycond"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/libevdev
	virtual/udev
"
RDEPEND="${DEPEND}
	games-util/hid-nintendo"
BDEPEND=""
IUSE="systemd"

src_install() {
	cmake_src_install
	if ! use systemd; then
		rm -rf "${D}"/etc/modules-load.d
		mkdir "${D}"/etc/init.d/
		echo -e "#!/sbin/openrc-run\ncommand=/usr/bin/${PN}" \
			> "${D}"/etc/init.d/${PN}
		chmod +x "${D}"/etc/init.d/${PN}
	fi
}
