# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Fish shell extension for printing execution time for each command"
HOMEPAGE="https://github.com/jichu4n/fish-command-timer"
SRC_URI="https://github.com/jichu4n/fish-command-timer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-shells/fish-2.2"

DOCS=( README.md )

src_install() {
	insinto "/usr/share/fish/vendor_conf.d"
	doins "conf.d/fish_command_timer.fish"
	einstalldocs
}
