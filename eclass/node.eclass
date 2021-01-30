# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EXPORT_FUNCTIONS src_prepare src_compile src_install src_test

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
	jq 'if .devDependencies? then .devDependencies[] = "*" else . end' package.json | sponge package.json || die
	default
}

node_src_compile() {
	#here we trick npm into believing there are no dependencies so it will not try to fetch them
	jq 'with_entries(if .key == "dependencies" then .key = "deps" else . end)' package.json | sponge package.json || die
	jq 'with_entries(if .key == "devDependencies" then .key = "devDeps" else . end)' package.json | sponge package.json || die

	#path to the modules
	export NODE_PATH="/usr/$(get_libdir)/node_modules"
	export npm_config_prefix="${T}/prefix"
	#path to the headers needed by node-gyp
	export npm_config_nodedir="/usr/include/node"
	in_iuse test || export NODE_ENV="production"
	npm install --global || die

	#restore original package.json
	jq 'with_entries(if .key == "deps" then .key = "dependencies" else . end)' package.json | sponge package.json || die
	jq 'with_entries(if .key == "devDeps" then .key = "devDependencies" else . end)' package.json | sponge package.json || die
}

node_src_install() {
	#copy files instead of symlinks
	rsync -avLAX "${T}/prefix/" "${ED}/usr" --exclude /bin || die

	if [ -d "${T}/prefix/bin" ] ; then
		#keep the symlinks
		rsync -avAX "${T}/prefix/bin/" "${ED}/usr/bin" || die
	fi
}

node_src_test() {
	npm test || die
}
