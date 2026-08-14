# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nim-utils

# inherit nimble
# simply isn't working for this package's use case
# need to probably rewrite another whole nimble eclass sooner or later
# also the eclass uses nimbus instead of the official nim package manager nimble
DESCRIPTION="Native messenger for Tridactyl, a vim-like web-extension"
HOMEPAGE="https://github.com/tridactyl/native_messenger"
SRC_URI="
	https://github.com/tridactyl/native_messenger/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"
# use these commands to generate the deps
# nimble build --localdeps
# find nimbledeps -exec file --mime-type {} \; |
# sed -nE 's/^(.+): (text\/\S+|application\/json)$/\1/p' |
# xargs tar --create --verbose --file nimbledeps.tar.xz
S="${WORKDIR}/native_messenger-${PV}"

LICENSE="BSD-2"

SLOT="0"

KEYWORDS="~amd64"

BDEPEND="dev-lang/nim"

src_configure(){
	nim_gen_config
}

src_compile() {
	nimble\
		--verbose\
		--offline\
		--localDeps\
		--nimbleDir:"${WORKDIR}/nimbledeps"\
		--useSystemNim\
		build ||
	die "build failed!"
}

src_install() {
	exeinto /usr/libexec/tridactyl
	doexe native_main
	sed -i -e "s|REPLACE_ME_WITH_SED|${EPREFIX}/usr/libexec/tridactyl/native_main|" ./tridactyl.json ||
	die "trying to sed installation path in tridactyl.json failed!"
	local target_dirs=( /usr/{lib,$(get_libdir)}/mozilla/native-messaging-hosts )
	local target_dir
	for target_dir in "${target_dirs[@]}"; do
		insinto "${target_dir}"
		doins tridactyl.json
	done
}
