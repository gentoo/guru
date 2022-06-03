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
# full path to octave binary
OCT_BIN="$(type -p octave)"

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

	_generate_configure

	if [[ -e "${S}/src/configure.ac" ]]; then
		edo pushd "${S}/src"
		eautoreconf
		edo popd
	elif [[ -e "${S}/src/autogen.sh" ]]; then
		edo pushd "${S}/src"
		edo ./autogen.sh
		edo popd
	fi
	if [[ -e "${S}/src/Makefile" ]]; then
		edo sed -i 's/ -s / /g' "${S}/src/Makefile"
	fi
}

octaveforge_src_compile() {
	PKGDIR="$(pwd | sed -e 's|^.*/||' || die)"
	export OCT_PACKAGE="${TMPDIR}/${PKGDIR}.tar.gz"
	export MKOCTFILE="mkoctfile -v"

	cmd="disp(__octave_config_info__('octlibdir'));"
	OCTLIBDIR=$(edo octavecommand "${cmd}")
	export LFLAGS="${LFLAGS} -L${OCTLIBDIR}"
	export LDFLAGS="${LDFLAGS} -L${OCTLIBDIR}"

	if [[ -e src/Makefile ]]; then
		emake -C src
	fi

	if [[ -e src/Makefile ]]; then
		edo mv src/Makefile src/Makefile.disable
	fi
	if [[ -e src/configure ]]; then
		edo mv src/configure src/configure.disable
	fi

	edo pushd ..
	edo tar -czf "${OCT_PACKAGE}" "${PKGDIR}"
}

# @FUNCTION: octaveforge_src_install
# @DESCRIPTION:
# function to install the octave package
octaveforge_src_install() {
	DESTDIR="${D}" edo _octaveforge_pkg_install
}

octaveforge_src_test() {
	DESTDIR="${T}" edo _octaveforge_pkg_install

	# cargo culted from Fedora
	cmd="
		pkg('load','${PN}');
		oruntests('${oct_pkgdir}');
		unlink(pkg('local_list'));
		unlink(pkg('global_list'));
	"
	edo octavecommand "${cmd}"
}

# @FUNCTION: octaveforge_pkg_postinst
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postinst() {
	einfo "Registering ${CATEGORY}/${PF} on the Octave package database."
	if [[ ! -d "${OCT_PKGDIR}" ]] ; then
		edo mkdir -p "${OCT_PKGDIR}"
	fi
	cmd="pkg('rebuild');"
	edo octavecommand "${cmd}"
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
	oct_pkgdir=$(edo octavecommand "${cmd}")
	edo rm -f "${oct_pkgdir}/packinfo/on_uninstall.m"
	if [[ -e "${oct_pkgdir}/packinfo/on_uninstall.m.orig" ]]; then
		edo mv "$oct_pkgdir"/packinfo/on_uninstall.m{.orig,}
		edo pushd "$oct_pkgdir/packinfo"
		cmd="
			l = pkg('list');
			on_uninstall(l{cellfun(@(x)strcmp(x.name,'${PN}'), l)});
		"
		edo octavecommand "${cmd}"
	fi
}

# @FUNCTION: octaveforge_pkg_postrm
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postrm() {
	einfo 'Rebuilding the Octave package database.'
	if [[ ! -d "${OCT_PKGDIR}" ]] ; then
		edo mkdir -p "${OCT_PKGDIR}"
	fi
	cmd="pkg('rebuild');"
	edo "${OCT_BIN}" -H --silent --no-gui --eval "${cmd}"
}

octavecommand() {
	edo "${OCT_BIN}" -H -q --no-site-file --no-gui --eval "$1"
}

_generate_configure() {
	edo cat << EOF > configure
#! /bin/sh -f

if [ -e src/configure ]; then
  cd src
  ./configure $*
fi
EOF
	edo chmod 0755 "configure"
}

_octaveforge_pkg_install() {
	TMPDIR="${T}"
	DISTPKG='Gentoo'

	edo pushd ../
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
		edo oct_pkgdir=$(edo octavecommand "${cmd}")
	else
		cmd="disp(fullfile(__octave_config_info__('datadir'),'octave'));"
		shareprefix=${DESTDIR}/$(edo octavecommand "${cmd}")
		cmd="disp(fullfile(__octave_config_info__('libdir'),'octave'));"
		libprefix=${DESTDIR}/$(edo octavecommand "${cmd}")
		octprefix="${shareprefix}/packages"
		archprefix="${libprefix}/packages"
		if [[ ! -e "${octprefix}" ]]; then
			edo mkdir -p "${octprefix}"
		fi
		if [[ ! -e "${archprefix}" ]]; then
			edo mkdir -p "${archprefix}"
		fi
		cmd="
			warning('off','all');
			pkg('prefix','${octprefix}','${archprefix}');
			pkg('global_list',fullfile('${shareprefix}','octave_packages'));
			pkg('local_list',fullfile('${shareprefix}','octave_packages'));
			pkg('install','-nodeps','-verbose','${OCT_PACKAGE}');
		"
		edo octavecommand "${cmd}"
		cmd="
			warning('off','all');
			pkg('prefix','${octprefix}','${archprefix}');
			pkg('global_list',fullfile('${shareprefix}','octave_packages'));
			pkg('local_list',fullfile('${shareprefix}','octave_packages'));
			l=pkg('list');
			disp(l{cellfun(@(x)strcmp(x.name,'${PN}'),l)}.dir);
			${stripcmd}
		"
		oct_pkgdir=$(edo octavecommand "${cmd}")
	fi
	export oct_pkgdir
}
