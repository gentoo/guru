# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EXPORT_FUNCTIONS src_prepare src_compile src_install

SLOT="0"
IUSE=""
DEPEND="net-libs/nodejs"
RDEPEND="${DEPEND}"
BDEPEND="
	app-misc/jq
	net-misc/rsync
	sys-apps/moreutils
"
S="${WORKDIR}/package"

node-guru_src_prepare() {
	#remove version constraints on dependencies
	jq 'if .dependencies? then .dependencies[] = "*" else . end' package.json | sponge package.json || die
	default
}

node-guru_src_compile() {
	#here we trick npm into believing there are no dependencies so it will not try to fetch them
	jq 'with_entries(if .key == "dependencies" then .key = "deps" else . end)' package.json | sponge package.json || die

	export npm_config_prefix="${T}/prefix"
	npm install -g --production || die

	#restore original package.json
	jq 'with_entries(if .key == "deps" then .key = "dependencies" else . end)' package.json | sponge package.json || die
}

node-guru_src_install() {
	#copy files instead of symlinks
	rsync -avLAX "${T}/prefix/" "${ED}/usr" --exclude /bin || die

	if [ -d "${T}/prefix/bin" ]
	then
		#keep the symlinks
		rsync -avAX "${T}/prefix/bin/" "${ED}/usr/bin" || die
	fi
}
