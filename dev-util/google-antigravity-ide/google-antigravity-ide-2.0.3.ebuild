# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi
		fil fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR
		pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop optfeature pax-utils shell-completion xdg

EXECUTION_ID="6242596486512640"

MY_PN="${PN#google-}"
DESCRIPTION="Google Antigravity's Editor view with context-aware agent"
HOMEPAGE="https://antigravity.google/"
BASE_URI="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/${PV}-${EXECUTION_ID}"
SRC_URI="
	amd64? ( ${BASE_URI}/linux-x64/Antigravity%20IDE.tar.gz -> ${P}_amd64.tar.gz )
	arm64? ( ${BASE_URI}/linux-arm/Antigravity%20IDE.tar.gz -> ${P}_arm64.tar.gz )
"
S="${WORKDIR}"

# It's complicated...
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="kerberos webkit"
RESTRICT="bindist mirror strip"

RDEPEND="
	|| (
		sys-apps/systemd
		sys-apps/systemd-utils
	)
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	virtual/zlib:=
	sys-process/lsof
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
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
	kerberos? ( app-crypt/mit-krb5 )
	webkit? (
		net-libs/libsoup:3.0
		net-libs/webkit-gtk:4.1
	)
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/${MY_PN}.*\\.desktop"

AGY_HOME_BASE="opt/google"
AGY_HOME="${AGY_HOME_BASE}/${MY_PN}"

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use amd64 || use arm64 || die "Google Antigravity IDE only works on amd64 or arm64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	default
	mv "Antigravity IDE" "${MY_PN}" || die
}

src_prepare() {
	default

	cd "${MY_PN}" || die

	pushd locales > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	if ! use kerberos; then
		rm -r resources/app/node_modules/kerberos || die
	fi

	if ! use webkit; then
		rm -r resources/app/extensions/microsoft-authentication || die
	fi
}

src_install() {
	cd "${MY_PN}" || die

	mkdir -p "${ED}/${AGY_HOME}" || die
	cp -r . "${ED}/${AGY_HOME}" || die

	pax-mark m "/${AGY_HOME}/bin/${MY_PN}"
	fperms 0755 "/${AGY_HOME}/${MY_PN}" "/${AGY_HOME}/bin/${MY_PN}"
	dosym "/${AGY_HOME}/bin/${MY_PN}" "/usr/bin/${MY_PN}"

	fperms 4711 "/${AGY_HOME}/chrome-sandbox"

	domenu "${FILESDIR}/${MY_PN}.desktop"
	newicon -s scalable "${ED}/${AGY_HOME}/resources/app/resources/linux/code.png" ${MY_PN}.png

	insinto /usr/share/metainfo
	doins "${FILESDIR}/${MY_PN}.metainfo.xml"

	insinto /usr/share/mime/packages
	doins "${FILESDIR}/${MY_PN}-workspace.xml"

	newbashcomp "${ED}/${AGY_HOME}/resources/completions/bash/antigravity-ide" antigravity-ide
	newzshcomp "${ED}/${AGY_HOME}/resources/completions/zsh/_antigravity-ide" _antigravity-ide
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
}
