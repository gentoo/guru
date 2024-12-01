EAPI=8

inherit desktop linux-info unpacker xdg

DESCRIPTION="Package for UnityHub"

HOMEPAGE="https://unity.com/unity-hub"

SRC_URI="https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/unityhub-amd64-3.9.1.deb"

S="${WORKDIR}"

LICENSE="Unity-TOS"

SLOT="0"

KEYWORDS="~amd64"

# IUSE=""

RDEPEND="
		app-accessibility/at-spi2-core:2
		dev-libs/expat
		dev-libs/glib:2
		dev-libs/nspr
		dev-util/lttng-ust
		media-libs/alsa-lib
		media-libs/mesa
		net-print/cups
		sys-apps/dbus
		sys-libs/zlib
		x11-libs/cairo
		dev-libs/nss
		x11-libs/gtk+:3
		app-alternatives/cpio
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
	dodir /opt/unityhub
	cp -r opt/* "${D}/opt/" || die
	dosym -r /opt/unityhub/unityhub /usr/bin/unityhub
	domenu usr/share/applications/unityhub.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/unityhub.png
	done
}
