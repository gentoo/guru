# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi
		fil fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR
		pt-PT ro ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/google-artifact-registry.asc

inherit chromium-2 eapi9-pipestatus optfeature pax-utils unpacker verify-sig xdg

BASE_SRC_URI="https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian"

# See ${BASE_SRC_URI}/main/binary-${ARCH}/Packages
BUILD_ID_AMD64="1770081357"
BUILD_ID_ARM64="1770081396"
DEB_HASH_AMD64="1e91c55b802c42d27f931c53e68fc2ab"
DEB_HASH_ARM64="c50fd2a09a9c4bc5a4ef2c96ff8b8d0b"

DESCRIPTION="Google's AI-first IDE and agentic development platform"
HOMEPAGE="https://antigravity.google/"
SRC_URI="
	amd64? ( ${BASE_SRC_URI}/antigravity_${PV}-${BUILD_ID_AMD64}_amd64_${DEB_HASH_AMD64}.deb -> ${P}_amd64.deb )
	arm64? ( ${BASE_SRC_URI}/antigravity_${PV}-${BUILD_ID_ARM64}_arm64_${DEB_HASH_ARM64}.deb -> ${P}_arm64.deb )
	verify-sig? (
		https://raw.githubusercontent.com/falbrechtskirchinger/overlay-assets/main/distfiles/${P}-verify-sig.tar.xz
	)
"
S="${WORKDIR}"

# It's complicated...
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="kerberos verify-sig"
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
	verify-sig? ( >=sec-keys/openpgp-keys-google-artifact-registry-20210504 )
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/antigravity.*\\.desktop"

# Google Chrome installs into opt/google/chrome
AG_HOME_BASE="opt/google"
AG_HOME="${AG_HOME_BASE}/antigravity"

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use amd64 || use arm64 || die "Google Antigravity only works on amd64 or arm64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	if use verify-sig; then
		unpack ${P}-verify-sig.tar.xz

		# Verify APT chain of trust:
		# InRelease (signed) -> Packages (checksum) -> .deb (checksum)
		# ${BASE_SRC_URI}/InRelease
		# ${BASE_SRC_URI}/main/binary-${ARCH}/Packages
		verify-sig_verify_message InRelease - \
			| sed "s,[0-9]\+ main/binary-${ARCH}.*,Packages.${ARCH}," \
			| verify-sig_verify_unsigned_checksums - sha256 Packages.${ARCH}
		pipestatus || die

		cd "${DISTDIR}" > /dev/null || die
		local BUILD_ID_ARCH=BUILD_ID_${ARCH^^}
		sed -n "/^Version: ${PV}-${!BUILD_ID_ARCH}/,/^SHA256:/p" \
			"${WORKDIR}/Packages.${ARCH}" \
			| sed "s,^SHA256: \(.*\),\1 ${P}_${ARCH}.deb," \
			| verify-sig_verify_unsigned_checksums - sha256 ${P}_${ARCH}.deb
		pipestatus || die
	fi
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker ${P}_${ARCH}.deb

	mkdir -p "${AG_HOME_BASE}" || die
	mv "usr/share/antigravity" "${AG_HOME_BASE}/" || die

	pushd "${AG_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	sed -e "/updateUrl/d" -i "${AG_HOME}/resources/app/product.json" || die

	if ! use kerberos; then
		rm -r "${AG_HOME}/resources/app/node_modules/kerberos" || die
	fi

	# Do we really need a separate MIME type for the same file?
	sed -e "s|application/x-antigravity-workspace|application/x-code-workspace|g" -i \
		usr/share/applications/*.desktop \
		usr/share/mime/packages/antigravity-workspace.xml || die

	sed -e "s|^Exec=/usr/share/antigravity/antigravity |Exec=/${AG_HOME}/antigravity |" \
		-i usr/share/applications/*.desktop || die

	mv usr/share/appdata usr/share/metainfo || die

	pax-mark m "${AG_HOME}/antigravity"
	dosym -r "/${AG_HOME}/bin/antigravity" "usr/bin/google-antigravity"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
}
