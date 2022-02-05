# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/coder/${MY_PN}/releases/download/v${PV}/${MY_P}-linux"

inherit systemd

DESCRIPTION="VS Code in the browser (binary version with unbundled node and ripgrep)"
HOMEPAGE="https://coder.com/"
SRC_URI="
	amd64? ( ${BASE_URI}-amd64.tar.gz )
	arm64? ( ${BASE_URI}-arm64.tar.gz )
"

RESTRICT="test"
LICENSE="MIT 0BSD ISC PYTHON BSD-2 BSD Apache-2.0 Unlicense LGPL-2.1+
	|| ( BSD-2 MIT Apache-2.0 )
	|| ( MIT CC0-1.0 )
	|| ( MIT WTFPL )
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="gnome-keyring"

RDEPEND="
	${DEPEND}
	>=net-libs/nodejs-14.0[ssl]
	sys-apps/ripgrep
	gnome-keyring? (
		app-crypt/libsecret
	)
"

S="${WORKDIR}/${MY_P}-linux-${ARCH}"

PATCHES=( "${FILESDIR}/${PN}-node.patch" )

DOCS=( "README.md" "ThirdPartyNotices.txt" )

QA_PREBUILT="
	/opt/code-server-bin/lib/coder-cloud-agent
	/opt/code-server-bin/node_modules/@node-rs/argon2-linux-x64-musl/argon2.linux-x64-musl.node
	/opt/code-server-bin/node_modules/@node-rs/argon2-linux-x64-gnu/argon2.linux-x64-gnu.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/native-is-elevated/build/Release/obj.target/iselevated.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/native-is-elevated/build/Release/iselevated.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/node-pty/build/Release/pty.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/native-watchdog/build/Release/obj.target/watchdog.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/native-watchdog/build/Release/watchdog.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/spdlog/build/Release/obj.target/spdlog.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/spdlog/build/Release/spdlog.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/vscode-nsfw/build/Release/obj.target/nsfw.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/vscode-nsfw/build/Release/nsfw.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@vscode/sqlite3/build/Release/obj.target/sqlite.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@vscode/sqlite3/build/Release/sqlite.node
"

QA_PRESTRIPPED="
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node
	/opt/code-server-bin/vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node
	/opt/code-server-bin/node_modules/@node-rs/argon2-linux-x64-musl/argon2.linux-x64-musl.node
"

src_prepare() {
	default

	# We remove as much precompiled code as we can,
	# node modules not written in JS cannot be removed
	# thus "-bin".

	# use system node
	rm ./node ./lib/node \
		|| die "Failed to remove bundled nodejs"

	# remove bundled ripgrep binary
	rm ./vendor/modules/code-oss-dev/node_modules/vscode-ripgrep/bin/rg \
		|| die "Failed to remove bundled ripgrep"

	# not needed
	rm ./code-server || die
	rm ./postinstall.sh || die

	# already in /usr/portage/licenses/MIT
	rm ./LICENSE.txt || die

	# For windows
	rm -rf ./vendor/modules/code-oss-dev/node_modules/windows-foreground-love || die
	rm -rf .vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/win32-x64 || die

	if [[ $ELIBC != "musl" ]]; then
		rm -rf ./node_modules/@node-rs/argon2-linux-x64-musl || die
		rm ./vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node || die
	elif [[ $ELIBC != "glibc" ]]; then
		rm ./vendor/modules/code-oss-dev/node_modules/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node || die
	fi

	# We don't need electron
	rm -rf ./vendor/modules/code-oss-dev/node_modules/electron || die
	rm ./vendor/modules/code-oss-dev/node_modules/.bin/electron
}

src_install() {
	einstalldocs

	insinto "/opt/${PN}"
	doins -r .
	fperms +x "/opt/${PN}/bin/${MY_PN}"
	dosym -r "/opt/${PN}/bin/${MY_PN}" "${EPREFIX}/usr/bin/${PN}"

	dosym -r "/usr/bin/rg" \
		"${EPREFIX}/opt/${PN}/vendor/modules/code-oss-dev/node_modules/vscode-ripgrep/bin/rg"

	systemd_douserunit "${FILESDIR}/${MY_PN}.service"
}

pkg_postinst() {
	elog "When using code-server systemd service run it as a user"
	elog "For example: 'systemctl --user enable --now code-server'"
}
