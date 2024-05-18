# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit git-r3 python-single-r1

DESCRIPTION="Plugins developed fro Gajim XMPP client"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/"
EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"

S="${WORKDIR}/${P%_p2}"

LICENSE="GPL-3"
SLOT="0"
MY_PLUGINS="acronyms_expander anti_spam clients_icons length_notifier
	message_box_size now_listen openpgp pgp plugins_translations
	quick_replies triggers"
IUSE="$(printf '+%s ' ${MY_PLUGINS[@]})"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		net-im/gajim[${PYTHON_SINGLE_USEDEP}]
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
