# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: octaveforge.eclass
# @AUTHOR:
# Rafael G. Martins <rafael@rafaelmartins.eng.br>
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# @BLURB: octaveforge helper eclass.
# @MAINTAINER:
# Alessandro Barbieri <lssndrbarbieri@gmail.com>
# @SUPPORTED_EAPIS: 8

inherit autotools edo

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install src_test pkg_postinst pkg_prerm pkg_postrm

# @ECLASS-VARIABLE: REPO_URI
# @DESCRIPTION:
# URI to the sourceforge octave-forge repository
REPO_URI="http://svn.code.sf.net/p/octave/code/trunk/octave-forge"

# defining some paths

# @ECLASS-VARIABLE: OCT_ROOT
# @DESCRIPTION:
# full path to octave share
OCT_ROOT="/usr/share/octave"

# @ECLASS-VARIABLE: OCT_PKGDIR
# @DESCRIPTION:
# path to octave pkgdir
OCT_PKGDIR="${OCT_ROOT}/packages"

# @ECLASS-VARIABLE: OCT_BIN
# @DESCRIPTION:
# octave binary name
OCT_BIN="octave"

SRC_URI="mirror://sourceforge/octave/${P}.tar.gz"
SLOT="0"

# @FUNCTION: octaveforge_src_unpack
# @DESCRIPTION:
# function to unpack and set the correct S
octaveforge_src_unpack() {
	default
	if [[ ! -d "${WORKDIR}/${P}" ]]; then
		S="${WORKDIR}/${PN}"
	fi
}

# @FUNCTION: octaveforge_src_prepare
# @DESCRIPTION:
# function to add octaveforge specific makefile and configure and reconfigure if possible
octaveforge_src_prepare() {
	default

	_generate_configure || die

	if [[ -e "${S}/src/configure.ac" ]]; then
		pushd "${S}/src" || die
		eautoreconf
		popd || die
	elif [[ -e "${S}/src/autogen.sh" ]]; then
		pushd "${S}/src" || die
		edo ./autogen.sh
		popd || die
	fi
	if [[ -e "${S}/src/Makefile" ]]; then
		sed -i 's/ -s / /g' "${S}/src/Makefile" || die
	fi
}

octaveforge_src_compile() {
	PKGDIR="$(pwd | sed -e 's|^.*/||' || die)"
	export OCT_PACKAGE="${TMPDIR}/${PKGDIR}.tar.gz"
	export MKOCTFILE="mkoctfile -v"

	cmd="disp(__octave_config_info__('octlibdir'));"
	OCTLIBDIR=$(octavecommand "${cmd}" || die)
	export LFLAGS="${LFLAGS} -L${OCTLIBDIR}"
	export LDFLAGS="${LDFLAGS} -L${OCTLIBDIR}"

	if [[ -e src/Makefile ]]; then
		emake -C src
	fi

	if [[ -e src/Makefile ]]; then
		mv src/Makefile src/Makefile.disable || die
	fi
	if [[ -e src/configure ]]; then
		mv src/configure src/configure.disable || die
	fi

	pushd .. || die
	tar -czf "${OCT_PACKAGE}" "${PKGDIR}" || die
}

# @FUNCTION: octaveforge_src_install
# @DESCRIPTION:
# function to install the octave package
octaveforge_src_install() {
	DESTDIR="${D}" _octaveforge_pkg_install || die
}

octaveforge_src_test() {
	DESTDIR="${T}" _octaveforge_pkg_install || die

	# cargo culted from Fedora
	cmd="
		pkg('load','${PN}');
		oruntests('${oct_pkgdir}');
		unlink(pkg('local_list'));
		unlink(pkg('global_list'));
	"
	octavecommand "${cmd}" || die
}

# @FUNCTION: octaveforge_pkg_postinst
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postinst() {
	einfo "Registering ${CATEGORY}/${PF} on the Octave package database."
	if [[ ! -d "${OCT_PKGDIR}" ]] ; then
		mkdir -p "${OCT_PKGDIR}" || die
	fi
	cmd="pkg('rebuild');"
	octavecommand "${cmd}" || die
}

# @FUNCTION: octaveforge_pkg_prerm
# @DESCRIPTION:
# function that will run on_uninstall routines to prepare the package to remove
octaveforge_pkg_prerm() {
	einfo 'Running on_uninstall routines to prepare the package to remove.'
	cmd="
		pkg('rebuild');
		l = pkg('list');
		disp(l{cellfun(@(x)strcmp(x.name,'${PN}'),l)}.dir);
	"
	oct_pkgdir=$(octavecommand "${cmd}" || die)
	rm -f "${oct_pkgdir}/packinfo/on_uninstall.m" || die
	if [[ -e "${oct_pkgdir}/packinfo/on_uninstall.m.orig" ]]; then
		mv "$oct_pkgdir"/packinfo/on_uninstall.m{.orig,} || die
		pushd "$oct_pkgdir/packinfo" || die
		cmd="
			l = pkg('list');
			on_uninstall(l{cellfun(@(x)strcmp(x.name,'${PN}'), l)});
		"
		octavecommand "${cmd}" || die
	fi
}

# @FUNCTION: octaveforge_pkg_postrm
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postrm() {
	einfo 'Rebuilding the Octave package database.'
	if [[ ! -d "${OCT_PKGDIR}" ]] ; then
		mkdir -p "${OCT_PKGDIR}" || die
	fi
	cmd="pkg('rebuild');"
	edo "${OCT_BIN}" -H --silent --no-gui --eval "${cmd}"
}

octavecommand() {
	edo "${OCT_BIN}" -H -q --no-site-file --no-gui --eval "$1"
}

_generate_configure() {
	cat << EOF > configure || die
#! /bin/sh -f

if [ -e src/configure ]; then
  cd src
  ./configure $*
fi
EOF
	chmod 0755 "configure" || die
}

_octaveforge_pkg_install() {
	TMPDIR="${T}"
	DISTPKG='Gentoo'

	pushd ../ || die
	if [[ "X${DISTPKG}X" != "XX" ]]; then
		stripcmd="
			unlink(pkg('local_list'));
			unlink(pkg('global_list'));
		"
	fi
	if [[ "X${DESTDIR}X" = "XX" ]]; then
		cmd="
			warning('off','all');
			pkg('install','${OCT_PACKAGE}');
			l=pkg('list');
			disp(l{cellfun(@(x)strcmp(x.name,'${PN}'),l)}.dir);
			${stripcmd}
		"
		oct_pkgdir=$(octavecommand "${cmd}" || die)
	else
		cmd="disp(fullfile(__octave_config_info__('datadir'),'octave'));"
		shareprefix=${DESTDIR}/$(octavecommand "${cmd}" || die)
		cmd="disp(fullfile(__octave_config_info__('libdir'),'octave'));"
		libprefix=${DESTDIR}/$(octavecommand "${cmd}" || die)
		octprefix="${shareprefix}/packages"
		archprefix="${libprefix}/packages"
		if [[ ! -e "${octprefix}" ]]; then
			mkdir -p "${octprefix}" || die
		fi
		if [[ ! -e "${archprefix}" ]]; then
			mkdir -p "${archprefix}" || die
		fi
		cmd="
			warning('off','all');
			pkg('prefix','${octprefix}','${archprefix}');
			pkg('global_list',fullfile('${shareprefix}','octave_packages'));
			pkg('local_list',fullfile('${shareprefix}','octave_packages'));
			pkg('install','-nodeps','-verbose','${OCT_PACKAGE}');
		"
		octavecommand "${cmd}" || die
		cmd="
			warning('off','all');
			pkg('prefix','${octprefix}','${archprefix}');
			pkg('global_list',fullfile('${shareprefix}','octave_packages'));
			pkg('local_list',fullfile('${shareprefix}','octave_packages'));
			l=pkg('list');
			disp(l{cellfun(@(x)strcmp(x.name,'${PN}'),l)}.dir);
			${stripcmd}
		"
		oct_pkgdir=$(octavecommand "${cmd}" || die)
	fi
	export oct_pkgdir
}
