# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Create and extract Electron ASAR archives"
HOMEPAGE="https://github.com/electron/asar"
SRC_URI="
	https://github.com/electron/asar/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/minorum/gentoo-dist/releases/download/${P}-yarn/${P}-yarn-deps.tar.xz
"

LICENSE="MIT Apache-2.0 BSD-2 BlueOak-1.0.0 ISC test? ( BSD CC0-1.0 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=net-libs/nodejs-22.12.0"
BDEPEND="${RDEPEND}"

DOCS=( README.md CHANGELOG.md LICENSE.md )

_yarn() {
	YARN_ENABLE_NETWORK=0 \
	YARN_ENABLE_TELEMETRY=0 \
	YARN_ENABLE_GLOBAL_CACHE=false \
	YARN_CACHE_FOLDER="${WORKDIR}/yarn-cache" \
	node .yarn/releases/yarn-4.10.3.cjs "$@"
}

src_prepare() {
	default
	_yarn install --immutable --immutable-cache --mode=skip-build || die
}

src_compile() {
	_yarn run build || die
}

src_test() {
	_yarn exec vitest run || die
}

src_install() {
	_yarn workspaces focus --production || die

	sed -i "s/\"version\": \"0.0.0-development\"/\"version\": \"${PV}\"/" package.json || die

	local dir="/usr/$(get_libdir)/node_modules/@electron/asar"
	insinto "${dir}"
	doins -r package.json lib

	insinto "${dir}/node_modules"
	doins -r node_modules/*

	exeinto "${dir}/bin"
	doexe bin/asar.mjs

	dosym -r "${dir}/bin/asar.mjs" /usr/bin/asar

	einstalldocs
}
