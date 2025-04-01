EAPI=8

inherit desktop linux-info unpacker xdg

DESCRIPTION="Morgen simplifies time management by consolidating all your calendars."

HOMEPAGE="https://www.morgen.so/"

SRC_URI="https://dl.todesktop.com/210203cqcj00tw1/linux/deb/x64 -> ${PN}-${PV}.deb"

S="${WORKDIR}"

LICENSE="Morgen-TOS"

SLOT="0"

KEYWORDS="~amd64"

# IUSE=""

RDEPEND="
		app-accessibility/at-spi2-core:2
		dev-libs/expat
		dev-libs/glib:2
		dev-libs/nspr
		dev-libs/nss
		media-libs/alsa-lib
		media-libs/mesa
		net-print/cups
		app-crypt/libsecret
		x11-libs/cairo
		x11-libs/gtk+:3
		x11-libs/libdrm
		x11-libs/libX11
		x11-libs/libxcb
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libxkbcommon
		x11-libs/libXrandr
		x11-libs/pango
"

# DEPEND=""

# BDEPEND=""

QA_PREBUILT="*"

src_install() {
	dodir /opt/Morgen
	cp -r opt/* "${D}/opt/" || die
	dosym -r /opt/Morgen/morgen /usr/bin/morgen
	domenu usr/share/applications/morgen.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/morgen.png
	done

	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/morgen.xml
}
