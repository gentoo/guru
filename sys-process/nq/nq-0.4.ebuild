# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Unix command line queue utility"
HOMEPAGE="https://git.vuxu.org/nq/about/"
SRC_URI="https://git.vuxu.org/${PN}/snapshot/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="shell +tq test"
RESTRICT="!test? ( test )"
REQUIRED_USE="shell? ( !test )" # shell alternatives currently fail tests

RDEPEND="
	shell? ( sys-apps/util-linux sys-apps/coreutils )
	tq? ( || ( app-misc/tmux app-misc/screen ) )
"
BDEPEND="test? ( dev-lang/perl )"

DOCS=( README.md NEWS.md )

src_compile() {
	if use shell; then
		cp nq.sh nq
		cp fq.sh fq
	fi
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Wno-unused-result"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr ALL="nq fq $(usev tq)" install
	einstalldocs
	insinto /usr/share/zsh/site-functions
	doins _nq
}
