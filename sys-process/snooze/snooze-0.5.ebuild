# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Run a command at a particular time"
HOMEPAGE="https://github.com/leahneukirchen/snooze"
SRC_URI="https://github.com/leahneukirchen/snooze/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc {README,NEWS}.md
}
