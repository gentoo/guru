# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit meson python-single-r1

DESCRIPTION="Tool to create Flatpak bundles from Portage ebuilds"
HOMEPAGE="https://github.com/StefanCristian/flatpakify"
SRC_URI="https://github.com/StefanCristian/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	|| (
		app-admin/doas
		kde-plasma/kdesu-gui
		app-admin/sudo
	)
	dev-util/flatpak-builder
	sys-apps/flatpak
	sys-apps/portage"
BDEPEND="dev-build/meson
	${PYTHON_DEPS}"
