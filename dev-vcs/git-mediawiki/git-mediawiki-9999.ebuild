# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=" Gate between Git and Mediawiki "
HOMEPAGE="https://github.com/Git-Mediawiki/Git-Mediawiki"
EGIT_REPO_URI="https://github.com/Git-Mediawiki/Git-Mediawiki.git"

inherit git-r3 perl-functions

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-vcs/git[perl]"
RDEPEND="
	${DEPEND}
	dev-perl/MediaWiki-API
	dev-perl/DateTime-Format-ISO8601
"
BDEPEND="${DEPEND}"

DOCS=(
	"README.md",
	"docs"
)

src_compile(){
	return
}

src_install(){
	exeinto "/usr/libexec/git-core"
	doexe git-remote-mediawiki
	doexe git-mw

	perl_domodule -C Git Git/Mediawiki.pm
}
