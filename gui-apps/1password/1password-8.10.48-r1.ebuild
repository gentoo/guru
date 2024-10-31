# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature rpm xdg

DESCRIPTION="The world’s most-loved password manager"
HOMEPAGE="https://1password.com"
SRC_URI="amd64? ( https://downloads.1password.com/linux/rpm/stable/x86_64/${P}.x86_64.rpm )"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip test bindist"

DEPEND="
	x11-misc/xdg-utils
	acct-group/1password
"
RDEPEND="
	${DEPEND}
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	|| (
		sys-apps/systemd-utils
		sys-apps/systemd
	)
	sys-auth/polkit
	sys-libs/zlib
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

src_unpack() {
	rpm_unpack ${P}.x86_64.rpm
}

QA_PREBUILT="opt/1Password/*"

src_install() {
	# Fill in policy kit file with a list of (the first 10) human users of the system.
	export POLICY_OWNERS
	POLICY_OWNERS="$(cut -d: -f1,3 /etc/passwd \
		| grep -E ':[0-9]{4}$' \
		| cut -d: -f1 \
		| head -n 10 \
		| sed 's/^/unix-user:/' \
		| tr '\n' ' ')"

	eval "cat <<EOF
$(cat opt/1Password/com.1password.1Password.policy.tpl)
EOF" > ./com.1password.1Password.policy
	rm opt/1Password/com.1password.1Password.policy.tpl

	insinto /usr/share/polkit-1/actions
	doins com.1password.1Password.policy

	unset POLICY_OWNERS

	cp -ar opt "${ED}" || die "Install failed!"
	cp -ar usr "${ED}" || die "Install failed!"

	fowners root:1password /opt/1Password/1Password-BrowserSupport || die
	fperms 4755 /opt/1Password/chrome-sandbox
	fperms 2755 /opt/1Password/1Password-BrowserSupport

	dosym -r /opt/1Password/1password /usr/bin/1password
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "cli support" app-misc/1password-cli
}
