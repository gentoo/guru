
EAPI=8

DESCRIPTION="Portable OpenBSD ksh"
HOMEPAGE="https://github.com/ibara/oksh"
SRC_URI="https://github.com/ibara/oksh/archive/refs/tags/${P}/${PV}.tar.gz"
S="${WORKDIR}/oksh-oksh-${PV}"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curses ksh lto small static"
FILESDIR="./files"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    econf \
        --prefix="${EPREFIX}/usr" \
        --bindir="${EPREFIX}/usr/bin" \
        --mandir="${EPREFIX}/usr/share/man" \
        $(use_enable curses) \
        $(use_enable lto) \
        $(use_enable small) \
        $(use_enable static)
}

src_compile() {
    emake
}

src_install() {
    dobin ${PN}
    insinto /etc
    dodoc "${S}/oksh.1"
	doins "${S}/ksh.kshrc"
	elog "If the ksh use flag is not enabled, you will need to add /bin/oksh to your /etc/shells"
}

