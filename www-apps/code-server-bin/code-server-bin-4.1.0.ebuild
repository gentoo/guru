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
	>=net-libs/nodejs-14[ssl]
	sys-apps/ripgrep
	gnome-keyring? (
		app-crypt/libsecret
	)
"

S="${WORKDIR}/${MY_P}-linux-${ARCH}"

PATCHES=( "${FILESDIR}/${PN}-node.patch" )

DOCS=( "README.md" "ThirdPartyNotices.txt" )

# Relative to parent
CODE_OSS_MODULES="vendor/modules/code-oss-dev/node_modules"

QA_PREBUILT="
	opt/${PN}/lib/coder-cloud-agent
	opt/${PN}/node_modules/argon2/lib/binding/napi-v3/argon2.node
	opt/${PN}/node_modules/argon2/build-tmp-napi-v3/Release/argon2.node
	opt/${PN}/node_modules/argon2/build-tmp-napi-v3/Release/obj.target/argon2.node
	opt/${PN}/node_modules/@node-rs/argon2-linux-x64-musl/argon2.linux-x64-musl.node
	opt/${PN}/node_modules/@node-rs/argon2-linux-x64-gnu/argon2.linux-x64-gnu.node
	opt/${PN}/${CODE_OSS_MODULES}/native-is-elevated/build/Release/obj.target/iselevated.node
	opt/${PN}/${CODE_OSS_MODULES}/native-is-elevated/build/Release/iselevated.node
	opt/${PN}/${CODE_OSS_MODULES}/node-pty/build/Release/pty.node
	opt/${PN}/${CODE_OSS_MODULES}/native-watchdog/build/Release/obj.target/watchdog.node
	opt/${PN}/${CODE_OSS_MODULES}/native-watchdog/build/Release/watchdog.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node
	opt/${PN}/${CODE_OSS_MODULES}/spdlog/build/Release/obj.target/spdlog.node
	opt/${PN}/${CODE_OSS_MODULES}/spdlog/build/Release/spdlog.node
	opt/${PN}/${CODE_OSS_MODULES}/vscode-nsfw/build/Release/obj.target/nsfw.node
	opt/${PN}/${CODE_OSS_MODULES}/vscode-nsfw/build/Release/nsfw.node
	opt/${PN}/${CODE_OSS_MODULES}/@vscode/sqlite3/build/Release/obj.target/sqlite.node
	opt/${PN}/${CODE_OSS_MODULES}/@vscode/sqlite3/build/Release/sqlite.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/build/Release/watcher.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/build/Release/obj.target/watcher.node
"

QA_PRESTRIPPED="
	opt/${PN}/node_modules/@node-rs/argon2-linux-x64-musl/argon2.linux-x64-musl.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node
	opt/${PN}/${CODE_OSS_MODULES}/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node
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
	rm ./"${CODE_OSS_MODULES}"/vscode-ripgrep/bin/rg \
		|| die "Failed to remove bundled ripgrep"

	# not needed
	rm ./code-server || die
	rm ./postinstall.sh || die

	# already in /usr/portage/licenses/MIT
	rm ./LICENSE.txt || die

	# For windows
	rm -rf ./"${CODE_OSS_MODULES}"/windows-foreground-love || die
	rm -rf ."${CODE_OSS_MODULES}"/@parcel/watcher/prebuilds/win32-x64 || die

	if [[ $ELIBC != "musl" ]]; then
		rm -rf ./node_modules/@node-rs/argon2-linux-x64-musl || die
		rm ./"${CODE_OSS_MODULES}"/@parcel/watcher/prebuilds/linux-x64/node.napi.musl.node || die
	elif [[ $ELIBC != "glibc" ]]; then
		rm ./"${CODE_OSS_MODULES}"/@parcel/watcher/prebuilds/linux-x64/node.napi.glibc.node || die
	fi

	# We don't need electron
	rm -rf ./"${CODE_OSS_MODULES}"/electron || die
	rm ./"${CODE_OSS_MODULES}"/.bin/electron
}

src_install() {
	einstalldocs

	insinto "/opt/${PN}"
	doins -r .
	fperms +x "/opt/${PN}/bin/${MY_PN}"
	dosym -r "/opt/${PN}/bin/${MY_PN}" "${EPREFIX}/usr/bin/${PN}"

	dosym -r "/usr/bin/rg" \
		"${EPREFIX}/opt/${PN}/${CODE_OSS_MODULES}/vscode-ripgrep/bin/rg"

	systemd_douserunit "${FILESDIR}/${MY_PN}.service"
}

pkg_postinst() {
	elog "When using code-server systemd service run it as a user"
	elog "For example: 'systemctl --user enable --now code-server'"
}
