EAPI=8

DESCRIPTION="Pulseaudio command-line mixer like amixer"
HOMEPAGE="https://github.com/cdemoulins/pamixer"
SRC_URI="https://github.com/cdemoulins/pamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    dev-libs/glib:2
    media-sound/pulseaudio
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
    eapply_user
}

src_configure() {
    meson setup build --prefix=/usr
}

src_compile() {
    ninja -C build
}



src_install() {

	DESTDIR="${ED}" ninja -C build install
}
