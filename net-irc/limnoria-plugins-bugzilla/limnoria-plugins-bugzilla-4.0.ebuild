# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="limnoria-bugzilla"
DESCRIPTION="Bugzilla integration plugin for the Limnoria IRC Bot"
HOMEPAGE="https://github.com/bugzilla/limnoria-bugzilla"
SRC_URI="https://github.com/bugzilla/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-irc/limnoria"

src_install() {
	default
	insinto /usr/share/limnoria-extra-plugins/Bugzilla/Bugzilla
	doins -r *
}

pkg_postinst() {
	elog "Before this plugin can be used, your bot will need to be told where to"
	elog "load it from. To do this, add /usr/share/limnoria-extra-plugins/Bugzilla when"
	elog "prompted during the bot creation wizard, or add it to a running bots config"
	elog "with the command"
	elog
	elog "    config directories.plugins [config directories.plugins], /usr/share/limnoria-extra-plugins/Bugzilla"
}
