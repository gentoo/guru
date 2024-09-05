# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1

DESCRIPTION="Real-time type-ahead completion for Zsh."
HOMEPAGE="https://github.com/marlonrichert/zsh-autocomplete"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/marlonrichert/zsh-autocomplete.git"
else
	SRC_URI="https://github.com/marlonrichert/zsh-autocomplete/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND=">=app-shells/zsh-5.8"

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/${PN}/${PN}.plugin.zsh
at the end of your ~/.zshrc"

src_install() {
	# Move repo/tarball folder to zsh "plugin folder"
	# Remove .git in 9999 (update using portage)
	[[ ${PV} == 9999 ]] && rm -r "${S}/.git"
	mkdir -p "${ED}/usr/share/zsh/site-functions/" || die
	mv "${S}" "${ED}/usr/share/zsh/site-functions/${PN}"

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
