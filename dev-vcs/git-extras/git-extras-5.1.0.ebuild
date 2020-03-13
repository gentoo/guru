# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="Little git extras"
HOMEPAGE="https://github.com/tj/git-extras"

if [[ $PV == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-vcs/git"

src_compile() { :; }

src_install() {
	emake install PREFIX="${EPREIFX}"/usr SYSCONFDIR="${EPREFIX}"/etc DESTDIR="${D}"

	rm -rf "${D}"/etc/bash_completion.d

	newbashcomp etc/bash_completion.sh ${PN}

	insinto /usr/share/zsh/site-functions
	newins etc/git-extras-completion.zsh _${PN}

}
