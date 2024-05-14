# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

COMMIT="c31cb283fe9d38ae0367fcd9a8aef6be14bcb927"

DESCRIPTION="user contributed stuff related to munin"
HOMEPAGE="https://github.com/munin-monitoring/contrib"
SRC_URI="https://github.com/munin-monitoring/contrib/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/contrib-${COMMIT}"
LICENSE="GPL-3+ Apache-2.0 GPL-2 LGPL-2 GPL-2+ LGPL-3+ MIT" #TODO: investigate all the licenses
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples +plugins templates tools"
RDEPEND="net-analyzer/munin"

README_PLUGINS=(
	plugins/README.md
	plugins/apache/apache_byprojects/README.md
	plugins/apache/apache_vhosts/README.txt
	plugins/apt/deb_packages/README.md
	plugins/jmx/readme.txt
	plugins/kamailio/README.md
	plugins/network/linux_if/README.md
	plugins/nfs-freebsd/README.rst
	plugins/nginx/nginx_byprojects/README.md
	plugins/prosody/README.rst
	plugins/rackspace/README
	plugins/tarsnap/README.md
	plugins/varnish/README-varnish4.md
	plugins/varnish/README.rst
	plugins/znc/README.md
	plugins/zope/README-zodb
)
README_TOOLS=(
	tools/munin-node-c/README
	tools/munin-node-from-hell/README.rst
	tools/munin-plugins-busybox/README
	tools/pmmn/plugins/README
	tools/pypmmn/README.rst
)

src_prepare() {
	default
	rm "plugins/nginx/nginx_byprojects/LICENSE.txt" || die
}

src_configure() {
	return
}

src_compile() {
	export CC=$(tc-getCC)

	pushd plugins/cpu || die
		emake multicpu1sec-c || die
		rm multicpu1sec-c.c || die
	popd
	pushd plugins/disk/smart-c || die
		emake
		rm *.h *.o *.c Makefile || die
	popd
	pushd plugins/network || die
		emake if1sec-c || die
		rm if1sec-c.c || die
	popd
}

src_install() {
	if use tools ; then
		for i in "${README_TOOLS[@]}" ; do
			p="${ED}/usr/share/doc/${PF}/${i%/*}"
			mkdir -p "${p}" || die
			mv "${i}" "${p}" || die
		done
		insinto "/usr/libexec/munin"
		doins -r tools
	fi

	if use plugins; then
		#install documentation in subfolders
		for i in plugins/{apt,network,}/*/example-graphs ; do
			p="${ED}/usr/share/doc/${PF}/${i}"
			mkdir -p "${p}" || die
			mv "${i}" "${p}" || die
		done
		for i in "${README_PLUGINS[@]}" ; do
			p="${ED}/usr/share/doc/${PF}/${i%/*}"
			mkdir -p "${p}" || die
			mv "${i}" "${p}" || die
		done

		#install plugins without getting mad at preserving exec bit
		mkdir -p "${ED}/usr/libexec/munin/plugins/contrib" || die
		mv plugins/* "${ED}/usr/libexec/munin/plugins/contrib" || die
	fi

	insinto "/etc/munin/templates"
	use templates && doins -r templates/munstrap

	use examples && dodoc -r samples/munin.conf

	dodoc README.md
}
