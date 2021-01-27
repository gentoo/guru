# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EXPORT_FUNCTIONS src_prepare src_compile src_install

RESTRICT+=" mirror"
SLOT="0"

SRC_URI="https://registry.npmjs.org/${PN}/-/${P}.tgz"

NODEJS_DEPEND="net-libs/nodejs"
NDDEJS_RDEPEND="${NODEJS_DEPEND}"
NODEJS_BDEPEND="
	app-misc/jq
	net-misc/rsync
	sys-apps/moreutils
"

DEPEND="${NODEJS_DEPEND}"
RDEPEND="${NODEJS_RDEPEND}"
BDEPEND="${NODEJS_BDEPEND}"

S="${WORKDIR}/package"

node_src_prepare() {
	#remove version constraints on dependencies
	jq 'if .dependencies? then .dependencies[] = "*" else . end' package.json | sponge package.json || die
	default
}

node_src_compile() {
	#here we trick npm into believing there are no dependencies so it will not try to fetch them
	jq 'with_entries(if .key == "dependencies" then .key = "deps" else . end)' package.json | sponge package.json || die

	export npm_config_prefix="${T}/prefix"
	npm install -g --production || die

	#restore original package.json
	jq 'with_entries(if .key == "deps" then .key = "dependencies" else . end)' package.json | sponge package.json || die
}

node_src_install() {
	#copy files instead of symlinks
	rsync -avLAX "${T}/prefix/" "${ED}/usr" --exclude /bin || die

	if [ -d "${T}/prefix/bin" ] ; then
		#keep the symlinks
		rsync -avAX "${T}/prefix/bin/" "${ED}/usr/bin" || die
	fi
}
