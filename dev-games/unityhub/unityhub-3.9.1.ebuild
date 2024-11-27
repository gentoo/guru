EAPI=8

inherit desktop linux-info unpacker xdg

DESCRIPTION="Package for UnityHub"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://unity.com/unity-hub"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/unityhub-amd64-3.9.1.deb"

LICENSE="CC0-1.0"

SLOT="0"

KEYWORDS="~amd64"

S="${WORKDIR}"

# IUSE=""

RDEPEND="dev-libs/nss x11-libs/gtk+ app-alternatives/cpio dev-libs/openssl" # technically this is supposed to be openssl 1.1

# DEPEND=""

# BDEPEND=""

QA_PREBUILT="*"

src_install() {
	dodir /opt/unityhub
	cp -r opt/* "${D}/opt/"
	dosym -r /opt/unityhub/unityhub /usr/bin/unityhub
	domenu usr/share/applications/unityhub.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/unityhub.png
	done
}

pkg_postinst() {
	xdg_pkg_postinst
}
