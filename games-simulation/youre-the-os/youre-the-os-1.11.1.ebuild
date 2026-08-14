# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Game where you are a computer's OS and have to manage processes, memory and I/O"
HOMEPAGE="https://github.com/plbrault/youre-the-os"
SRC_URI="https://github.com/plbrault/youre-the-os/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
dev-python/pygame
dev-python/pipenv
"

DEPEND="${RDEPEND}"

inherit desktop wrapper

src_install() {
	local destdir="/usr/share/${PN}"
	insinto "${destdir}"

	doins -r src automation favicon.png run-*.py Pipfile LICENSE.txt

	local script
	for script in run-*.py; do
		fperms +x "${destdir}/${script}"
	done

	make_wrapper "${PN}" "python3 run-desktop.py" "${destdir}"
	make_wrapper "${PN}-sandbox" "python3 run-sandbox.py" "${destdir}"
	make_wrapper "${PN}-auto" "python3 run-auto.py" "${destdir}"

	newicon favicon.png "${PN}.png"
	make_desktop_entry "${PN}" "You're the OS!" "${PN}" "Game;Simulation;"
}
