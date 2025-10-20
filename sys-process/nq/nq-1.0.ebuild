# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs shell-completion

DESCRIPTION="Unix command line queue utility"
HOMEPAGE="https://git.vuxu.org/nq/about/"
SRC_URI="https://git.vuxu.org/${PN}/snapshot/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="shell +nqterm test"
RESTRICT="!test? ( test )"
REQUIRED_USE="shell? ( !test )" # shell alternatives currently fail tests

RDEPEND="
	shell? ( sys-apps/util-linux sys-apps/coreutils )
	nqterm? ( || ( app-misc/tmux app-misc/screen ) )
"
BDEPEND="test? ( dev-lang/perl )"

DOCS=( README.md NEWS.md )

src_compile() {
	if use shell; then
		cp nq.sh nq
		cp nqtail.sh nqtail
	fi
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Wno-unused-result"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr ALL="nq nqtail $(usev nqterm)" install
	einstalldocs
	dozshcomp _nq
}
