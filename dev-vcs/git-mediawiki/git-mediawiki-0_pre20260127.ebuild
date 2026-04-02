# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=" Gate between Git and Mediawiki "
HOMEPAGE="https://github.com/Git-Mediawiki/Git-Mediawiki"

inherit perl-functions

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Git-Mediawiki/Git-Mediawiki.git"
else
	GIT_COMMIT=c493d54bb1504d2efc02372e37b2e66c3c6e5530
	MY_PN="Git-Mediawiki"
	SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/"${MY_PN}-${GIT_COMMIT}"
	KEYWORDS="~amd64 ~arm64"
fi

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
