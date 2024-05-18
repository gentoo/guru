# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop linux-info xdg-utils

MY_PN="Dwarf-Therapist"
MY_PV="v${PV}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="For managing dwarves in Dwarf Fortress"
HOMEPAGE="https://github.com/Dwarf-Therapist/Dwarf-Therapist"
SRC_URI="https://github.com/Dwarf-Therapist/${MY_PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
"

CONFIG_CHECK="~CROSS_MEMORY_ATTACH"
WARNING_CROSS_MEMORY_ATTACH="required to interact with Dwarf Fortress"

src_install() {
	# Install some sort of documentation
	dodoc README.rst

	# Add the desktop file
	domenu dist/xdg/applications/dwarftherapist.desktop

	# install icons
	insinto /usr/share/
	doins -r dist/xdg/icons

	# install memory layout files for dwarf-fortress versions
	insinto /usr/share/dwarftherapist/memory_layouts
	doins -r share/memory_layouts/linux

	# and of course, the binary
	newbin "${BUILD_DIR}/dwarftherapist" dwarf-therapist
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
