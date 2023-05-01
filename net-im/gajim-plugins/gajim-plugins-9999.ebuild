# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-single-r1

DESCRIPTION="Plugins developed fro Gajim XMPP client"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/"

inherit git-r3
EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"

MY_PLUGINS="acronyms_expander anti_spam clients_icons length_notifier message_box_size now_listen omemo openpgp pgp plugins_translations quick_replies triggers"

LICENSE="GPL-3"
SLOT="0"
IUSE="$(printf '+%s ' ${MY_PLUGINS[@]})"
S="${WORKDIR}/${P%_p2}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		net-im/gajim[${PYTHON_SINGLE_USEDEP}]
		omemo? (
			net-im/gajim[omemo]
			dev-python/python-axolotl[${PYTHON_USEDEP}]
			dev-python/qrcode[${PYTHON_USEDEP}]
			dev-python/cryptography[${PYTHON_USEDEP}] )
		pgp? (
			>=dev-python/python-gnupg-0.4.0[${PYTHON_USEDEP}]
		)
		plugins_translations? (
			app-misc/geoclue[introspection]
		)
	')"

src_install() {
	python_moduleinto "gajim/data/plugins"

	for plugin in $MY_PLUGINS; do
		if use ${plugin#"+"}; then
			python_domodule "${plugin#"+"}"
		fi
	done
}
