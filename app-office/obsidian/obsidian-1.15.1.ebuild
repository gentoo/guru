# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop xdg

DESCRIPTION="A second brain, for you, forever"
HOMEPAGE="https://obsidian.md/"
SRC_URI="
	amd64? (
		https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P}.tar.gz
			-> ${P}-amd64.tar.gz
	)
	arm64? (
		https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P}-arm64.tar.gz
	)
"

LICENSE="Obsidian-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_PREBUILT="opt/Obsidian/*"
DOCS=( LICENSE.electron.txt LICENSES.chromium.html )

src_unpack() {
	default
	case ${ARCH} in
		amd64) S="${WORKDIR}/${P}" ;;
		arm64) S="${WORKDIR}/${P}-arm64" ;;
		*) die "Unsupported architecture: ${ARCH}" ;;
	esac
}

src_configure() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	cd locales || die
	chromium_remove_language_paks
}

src_install() {
	local dir="/opt/Obsidian"

	insinto "${dir}"
	doins -r .

	fperms 0755 \
		"${dir}/obsidian" \
		"${dir}/obsidian-cli" \
		"${dir}/chrome_crashpad_handler"

	fperms 4711 "${dir}/chrome-sandbox"

	dosym "${dir}/obsidian" /usr/bin/obsidian
	dosym "${dir}/obsidian-cli" /usr/bin/obsidian-cli

	newicon -s 512 resources/icon.png obsidian.png

	make_desktop_entry --eapi9 obsidian -n Obsidian \
					   -a "%U" \
					   -e "StartupWMClass=md.obsidian.Obsidian" \
					   -e "MimeType=application/pdf;text/markdown;application/x-obsidian-canvas;application/x-obsidian-base;x-scheme-handler/obsidian;"

	einstalldocs
}
