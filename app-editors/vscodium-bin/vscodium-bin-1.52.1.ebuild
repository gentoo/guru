# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

MY_PN="${PN/-bin}"

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode"
HOMEPAGE="https://vscodium.com"
SRC_URI="
	amd64? (
		https://github.com/VSCodium/${MY_PN}/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz
	)
	arm64? (
		https://github.com/VSCodium/${MY_PN}/releases/download/${PV}/VSCodium-linux-arm64-${PV}.tar.gz
	)
"

RESTRICT="bindist strip test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="libsecret"

RDEPEND="
	app-accessibility/at-spi2-atk
	dev-libs/nss
	media-libs/libpng:0/16
	sys-apps/ripgrep
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libnotify
	x11-libs/pango
	libsecret? ( app-crypt/libsecret[crypt]	)
"

S="${WORKDIR}"

src_prepare() {
	default

	# Unbundle ripgrep
	rm "resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg" || die
}

src_install() {
	pax-mark m codium
	insinto "/opt/${MY_PN}"
	doins -r *
	dosym "../../opt/${MY_PN}/bin/codium" "usr/bin/codium"

	domenu "${FILESDIR}/codium.desktop"
	domenu "${FILESDIR}/codium-url-handler.desktop"

	fperms +x /opt/${MY_PN}/{,bin/}codium
	fperms +x /opt/${MY_PN}/chrome-sandbox
	fperms -R +x /opt/${MY_PN}/resources/app/out/vs/base/node

	dosym "../../../../../../../usr/bin/rg" "${EPREFIX}/opt/${MY_PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	dodoc resources/app/LICENSE.txt resources/app/ThirdPartyNotices.txt
	newicon resources/app/resources/linux/code.png ${MY_PN}.png
}
