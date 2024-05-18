# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/coder/${MY_PN}/releases/download/v${PV}/${MY_P}-linux"

inherit systemd

DESCRIPTION="VS Code in the browser (binary version with unbundled node and ripgrep)"
HOMEPAGE="https://coder.com/"
SRC_URI="
	amd64? ( ${BASE_URI}-amd64.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( ${BASE_URI}-arm64.tar.gz -> ${P}-arm64.tar.gz )
"
S="${WORKDIR}/${MY_P}-linux-${ARCH}"

LICENSE="MIT ISC BSD Apache-2.0 BSD-2 PYTHON 0BSD"
LICENSE+=" LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="test"

RDEPEND="
	app-crypt/libsecret
	>=net-libs/nodejs-18.0.0[ssl]
	sys-apps/ripgrep
	virtual/krb5
"

PATCHES=( "${FILESDIR}/${PN}-node.patch" )

DOCS=( README.md ThirdPartyNotices.txt )

QA_PREBUILT="*"

# Relative
VSCODE_MODULES="lib/vscode/node_modules"
QA_PRESTRIPPED="
	opt/${PN}/node_modules/@node-rs/argon2-linux-x64-musl/argon2.linux-x64-musl.node
	opt/${PN}/${VSCODE_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node
	opt/${PN}/${VSCODE_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node
"

src_prepare() {
	default

	# We remove as much precompiled code as we can,
	# node modules not written in JS cannot be removed
	# thus "-bin".

	# use system node
	rm ./lib/node || die "Failed to remove bundled nodejs"

	# remove bundled ripgrep binary
	rm ./"${VSCODE_MODULES}"/@vscode/ripgrep/bin/rg \
		|| die "Failed to remove bundled ripgrep"

	# Only required at build time
	find "${S}" -type l -name python3 -delete || die

	# not needed
	rm ./postinstall.sh || die

	# For windows
	rm -r ./"${VSCODE_MODULES}"/@parcel/watcher/prebuilds/win32-x64 || die

	if [[ $ELIBC != "musl" ]]; then
		rm ./"${VSCODE_MODULES}"/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node || die
	elif [[ $ELIBC != "glibc" ]]; then
		rm ./"${VSCODE_MODULES}"/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node || die
		rm ./"${VSCODE_MODULES}"/@parcel/watcher/prebuilds/darwin-x64/node.napi.glibc.node || die
		rm ./"${VSCODE_MODULES}"/@parcel/watcher/prebuilds/darwin-arm64/node.napi.glibc.node || die
	fi

	rm -r ./lib/vscode/extensions/node_modules/.bin || die
}

src_install() {
	einstalldocs

	insinto "/opt/${PN}"
	doins -r .
	fperms +x "/opt/${PN}/bin/${MY_PN}"
	dosym -r "/opt/${PN}/bin/${MY_PN}" "/opt/${PN}/bin/${PN}"
	dosym -r "/opt/${PN}/bin/${PN}" "/usr/bin/${PN}"

	dosym -r "/usr/bin/rg" \
		"/opt/${PN}/${VSCODE_MODULES}/@vscode/ripgrep/bin/rg"

	systemd_douserunit "${FILESDIR}/${PN}.service"
	newinitd "${FILESDIR}/${PN}.rc" "${PN}"
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
}

pkg_postinst() {
	elog "When using code-server systemd service run it as a user"
	elog "For example: 'systemctl --user enable --now code-server'"
}
