# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

inherit chromium-2 desktop optfeature xdg

DESCRIPTION="Password manager and secure wallet"
HOMEPAGE="https://1password.com"
SRC_URI="
	amd64? ( https://downloads.1password.com/linux/tar/stable/x86_64/${P}.x64.tar.gz )
	arm64? ( https://downloads.1password.com/linux/tar/stable/aarch64/${P}.arm64.tar.gz )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	acct-group/onepassword
	acct-group/onepassword-mcp
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-auth/polkit
	x11-libs/cairo
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
	x11-misc/xdg-utils
	virtual/libudev
	virtual/zlib
"

QA_PREBUILT="opt/1Password/*"

src_unpack() {
	default
	case ${ARCH} in
		amd64) S="${WORKDIR}/${P}.x64" ;;
		arm64) S="${WORKDIR}/${P}.arm64" ;;
		*) die "Unsupported architecture: ${ARCH}" ;;
	esac
}

src_prepare() {
	default

	# allow members of the onepassword group to authorize CLI and SSH agent
	sed -e 's/\${POLICY_OWNERS}/unix-group:onepassword/g' \
		com.1password.1Password.policy.tpl > "${T}"/com.1password.1Password.policy || die

	# remove the vendor installers
	rm install.sh after-install.sh after-remove.sh \
		install_biometrics_policy.sh || die

}

src_install() {
	# cleanup languages
	pushd locales > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	insinto /usr/share/polkit-1/actions
	doins "${T}"/com.1password.1Password.policy

	domenu resources/com.onepassword.OnePassword.desktop
	local size
	for size in 32 64 256 512; do
		doicon -s "${size}" \
		"resources/icons/hicolor/${size}x${size}/apps/1password.png" || die
	done

	dodoc resources/custom_allowed_browsers
	insinto /etc/1password
	doins resources/custom_allowed_browsers

	insinto /etc/apparmor.d
	newins resources/apparmor-profile 1password

	# Remove resources installed into system directories.
	rm -r \
		resources/icons \
		resources/com.onepassword.OnePassword.desktop \
		resources/custom_allowed_browsers \
		resources/apparmor-profile || die

	# Remove the source policy template.
	rm com.1password.1Password.policy.tpl || die

	dodir /opt
	mv "${S}" "${ED}/opt/1Password" || die

	dosym -r /opt/1Password/1password /usr/bin/1password
	dosym -r /opt/1Password/1password-mcp /usr/bin/1password-mcp
	# preserve the vendor-supported path used by existing MCP clients
	# source: after-install.sh
	dosym 1password-mcp /opt/1Password/onepassword-mcp

	# https://github.com/electron/electron/issues/17972
	fperms 4711 /opt/1Password/chrome-sandbox

	fowners :onepassword /opt/1Password/1Password-BrowserSupport
	fperms g+s /opt/1Password/1Password-BrowserSupport

	fowners :onepassword-mcp /opt/1Password/1password-mcp
	fperms g+s /opt/1Password/1password-mcp
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "To enable browser integration, SSH agent, and CLI unlock,"
	elog "your user account must be part of the 'onepassword' group:"
	elog "    usermod -aG onepassword \$USER"

	if has_version "acct-group/onepassword-mcp"; then
		elog ""
		elog "To use the 1Password MCP integration, add your user to the 'onepassword-mcp' group:"
		elog "    usermod -aG onepassword-mcp \$USER"
	fi

	optfeature "1Password CLI" app-misc/1password-cli
}
