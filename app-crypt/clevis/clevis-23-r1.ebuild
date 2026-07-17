# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson shell-completion

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dracut pkcs11 test tpm1 udisks"

BDEPEND="app-text/asciidoc
	test? (	app-crypt/swtpm
		net-misc/socat
		sys-process/lsof
	)
	udisks? ( dev-util/glib-utils )
"

# dev-libs/openssl is an  automagic dependency for clevis sss pin
# net-misc/curl is an automagic dependency for clevis tang pin
# app-crypt/tpm2-tools is an automagic dependency for clevis tpm2 pin
# Even though they are only invoked at rum time, the build process will not include
# support if they are not on the build host, hance they must be DEPEND.

PINS_AUTOMAGIC_DEPEND="
	dev-libs/openssl:=
	net-misc/curl
	app-crypt/tpm2-tools
"

# sys-fs/cryptsetup and dev-libs/luksmeta are automagic dependencies for LUKS support
DEPEND="
	${PINS_AUTOMAGIC_DEPEND}
	dev-libs/jansson
	dev-libs/jose
	dev-libs/luksmeta
	sys-fs/cryptsetup
	dracut? ( sys-kernel/dracut )
	pkcs11? (
		dev-libs/opensc
		sys-apps/pcsc-lite[policykit]
	)
	tpm1? ( app-crypt/tpm-tools )
	udisks? (
		dev-libs/glib
		sys-fs/udisks
		sys-process/audit
	)
"

# clevis-luks-edit has an RDEPEND on app-misc/jq
RDEPEND="
	${DEPEND}
	app-misc/jq
	app-crypt/tpm2-tools
"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${PN}-23-openrc-fixes.patch"
	"${FILESDIR}/${PN}-23-cleanup-meson-deprecation-warnings.patch"
	"${FILESDIR}/${PN}-23-disable-automagic.patch"
	"${FILESDIR}/${PN}-23-disable-pkcs11-automagic.patch"
)

src_configure() {
	local emesonargs=(
		$(meson_feature dracut)
		$(meson_feature pkcs11)
		$(meson_feature tpm1)
		$(meson_feature udisks)
		"-Dbashcompdir=$(get_bashcompdir)"
	)
	meson_src_configure
}

# Most of the tests require root (FEATURES="-userpriv")
# To run the tang pin tests, install app-crypt/tang beforehand
src_test() {
	local excludedtests=(
# Doesn't work in the sandbox or without root
		"pin-tpm2-sw"
	)
	meson_src_test $(meson test -C "${BUILD_DIR}" --list | grep -v "${excludedtests[@]}")
}
