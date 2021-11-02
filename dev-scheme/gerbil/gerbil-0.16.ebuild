# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp-common toolchain-funcs wrapper xdg-utils

DESCRIPTION="Dialect of Scheme designed for Systems Programming"
HOMEPAGE="https://cons.io/ https://github.com/vyzo/gerbil"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vyzo/${PN}.git"
else
	SRC_URI="https://github.com/vyzo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0 LGPL-2.1"
SLOT="0"
IUSE="emacs leveldb lmdb mysql +sqlite +xml yaml +zlib"

BDEPEND="dev-scheme/gambit"
RDEPEND="
	dev-scheme/gambit
	emacs? ( >=app-editors/emacs-23.1:* )
	leveldb? ( dev-libs/leveldb )
	lmdb? ( dev-db/lmdb )
	mysql? ( dev-db/mariadb:* )
	sqlite? ( dev-db/sqlite )
	xml? ( dev-libs/libxml2 )
	yaml? ( dev-libs/libyaml )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/src"

SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	# Just to be safe, because './configure --help' says:
	# "Set default GERBIL_HOME (environment variable still overrides)"
	unset GERBIL_HOME
	unset GERBIL_PATH
	xdg_environment_reset

	# Verbose build process
	GAMBCOMP_VERBOSE="yes"
	export GAMBCOMP_VERBOSE

	default

	sed -i "s|gcc|$(tc-getCC)|g" ./build.sh || die "Failed to fix CC setting"
	sed -i "s|-O2|${CFLAGS}|g" ./build.sh || die "Failed to fix CFLAGS setting"
}

src_configure() {
	local myconf=(
		$(use_enable leveldb)
		$(use_enable lmdb)
		$(use_enable mysql)
		$(use_enable xml libxml)
		$(use_enable yaml libyaml)
		$(usex sqlite '' '--disable-sqlite')
		$(usex zlib '' '--disable-zlib')
		--prefix="${D}/usr/share/${PN}"
	)
	# This is not a standard 'configure' script!
	gsi ./configure "${myconf[@]}" ||
		die "Failed to configure using the 'configure' script"
}

src_compile() {
	# The 'build.sh' script uses environment variables that are exported
	# by portage, ie.: CFLAGS, LDFLAGS, ...
	sh ./build.sh ||
		die "Failed to compile using the 'build.sh' script"
}

src_install() {
	mkdir -p "${D}/usr/share/${PN}" ||
		die "Failed to make ${D}/usr/share/${PN} directory"
	gsi ./install || die "Failed to install using the 'install' script"

	sed -i "s|${D}|${EPREFIX}|g" "${D}/usr/share/${PN}/bin/gxc" ||
		die "Failed to fix the 'gxc' executable script"

	mv "${D}/usr/share/${PN}/share/emacs" "${D}/usr/share/emacs" ||
		die "Failed to fix '/usr/share/emacs' install path"
	mv "${D}/usr/share/${PN}/share/${PN}/TAGS" "${D}/usr/share/${PN}/TAGS" ||
		die "Failed to fix '/usr/share/gerbil/TAGS' install path"

	# Compile the 'gerbil-mode.el'
	if use emacs; then
		elisp-compile "${D}/usr/share/emacs/site-lisp/gerbil"/*.el ||
			die "Failed to compile elisp files"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	# Create wrappers for gerbil executables in GERBIL_HOME (/usr/share/gerbil)
	pushd "${D}/usr/share/${PN}/bin" || die
	local gx_bin
	for gx_bin in *; do
		make_wrapper "${gx_bin}" "env GERBIL_HOME=\"${EPREFIX}/usr/share/${PN}\" ${EPREFIX}/usr/share/${PN}/bin/${gx_bin}"
	done
	popd || die

	# Without this the programs compiled with gxc will break!
	doenvd "${FILESDIR}/99${PN}"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
