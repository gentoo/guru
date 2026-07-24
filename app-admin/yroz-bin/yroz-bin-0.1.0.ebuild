EAPI=8

DESCRIPTION="Universal software manager for Linux (precompiled binary)"
HOMEPAGE="https://github.com/Yrozxm/Yroz-cli"
SRC_URI="
    amd64? ( https://github.com/Yrozxm/Yroz-cli/releases/download/v${PV}/yroz-x86_64 -> ${P}-amd64 )
    arm64? ( https://github.com/Yrozxm/Yroz-cli/releases/download/v${PV}/yroz-aarch64 -> ${P}-arm64 )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
    if use amd64; then
        newbin "${DISTDIR}/${P}-amd64" yroz
    elif use arm64; then
        newbin "${DISTDIR}/${P}-arm64" yroz
    fi
}
