# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker rust xdg

DESCRIPTION="A glossy Matrix collaboration client for desktop"
HOMEPAGE="https://element.io"
SRC_URI="https://github.com/element-hq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/element-hq/element-web/archive/v${PV}.tar.gz -> element-web-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+emoji keyring"

RESTRICT="network-sandbox" #The setup script needs internet connection, including for yarn install

RDEPEND="
	!net-im/element-desktop-bin
	>=app-accessibility/at-spi2-core-2.46.0
	app-crypt/libsecret
	dev-db/sqlcipher
	dev-libs/expat
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-libs/nodejs
	net-print/cups
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	x11-libs/pango
	emoji? ( media-fonts/noto-emoji )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	sys-apps/yarn
	>=net-libs/nodejs-22.18.0
"

QA_PREBUILT="
	opt/Element/chrome-sandbox
	opt/Element/libEGL.so
	opt/Element/chrome_crashpad_handler
	opt/Element/resources/app.asar.unpacked/node_modules/matrix-seshat/index.node
	opt/Element/element-desktop
	opt/Element/libffmpeg.so
	opt/Element/libvulkan.so.1
	opt/Element/libGLESv2.so
	opt/Element/libvk_swiftshader.so
"

ELEMENT_WEB_S="${WORKDIR}/element-web-${PV}"

pkg_setup() {
	rust_pkg_setup
}

src_prepare() {
	default
	pushd "${ELEMENT_WEB_S}" >/dev/null || die
	yarn install || die
	cp config.sample.json config.json || die
	popd >/dev/null || die

	yarn install || die
}

src_compile() {
	pushd "${ELEMENT_WEB_S}" >/dev/null || die
	yarn build || die
	popd >/dev/null || die

	ln -s "${ELEMENT_WEB_S}"/webapp ./ || die
	yarn build:native || die
	# Use sed to temporarily fix upstream bug in app-builder-lib https://github.com/electron-userland/electron-builder/issues/9355
	sed -i 's/else if (isCi) {/else if (isCi.isCI) {/' node_modules/app-builder-lib/out/publish/PublishManager.js || die
	yarn build || die
}

src_test() {
	pushd "${ELEMENT_WEB_S}" >/dev/null || die
	yarn test || die
	popd >/dev/null || die

	# Right now I can't figure out how to run playwright
	# under virtx so this test is commented out
	# Help will be appreciated, need to tell the browser
	# to run without a proper gpu support
	#virtx dbus-launch npx playwright test --ignore-snapshots --reporter html
}


src_install() {
	unpack dist/${PN}_${PV}_amd64.deb
	tar -xvf data.tar.xz || die

	./node_modules/@electron/universal/node_modules/@electron/asar/bin/asar.js p webapp opt/Element/resources/webapp.asar || die
	mv -n usr/share/doc/${PN} usr/share/doc/${PF} || die
	gunzip usr/share/doc/${PF}/changelog.gz || die

	insinto /
	doins -r usr
	doins -r opt
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
	fperms u+s /opt/Element/chrome-sandbox

	dosym ../../opt/Element/${PN} /usr/bin/${PN}
	dosym ${PN} /usr/bin/riot-desktop
}
