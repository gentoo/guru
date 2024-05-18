EAPI=8

DESCRIPTION="A POSIX Shell script to easily control brightness on backlight-controllers"
HOMEPAGE="https://github.com/Ventto/lux"
SRC_URI="https://github.com/Ventto/lux/archive/refs/tags/v1.21.tar.gz -> lux-1.21.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/lux-1.21"
src_prepare() {
    eapply_user
}

src_compile() {
    :
}

src_install() {

    emake DESTDIR="$D" install
    dodoc README.md
}

