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

inherit autotools

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

EXPORT_FUNCTIONS src_unpack src_prepare src_install pkg_postinst pkg_prerm pkg_postrm

# @ECLASS-VARIABLE: OCTAVEFORGE_CAT
# @DESCRIPTION:
# the octave-forge category of the package.
OCTAVEFORGE_CAT="${OCTAVEFORGE_CAT:-main}"

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

SRC_URI="
	mirror://sourceforge/octave/${P}.tar.gz
	${REPO_URI}/packages/package_Makefile.in -> octaveforge_Makefile
	${REPO_URI}/packages/package_configure.in -> octaveforge_configure
"
SLOT="0"

# @FUNCTION: octaveforge_src_unpack
# @DESCRIPTION:
# function to unpack and set the correct S
octaveforge_src_unpack() {
	default
	if [ ! -d "${WORKDIR}/${P}" ]; then
		S="${WORKDIR}/${PN}"
		pushd "${S}" || die
	fi
}

# @FUNCTION: octaveforge_src_prepare
# @DESCRIPTION:
# function to add octaveforge specific makefile and configure and run autogen.sh if available
octaveforge_src_prepare() {
	for filename in Makefile configure; do
		cp "${DISTDIR}/octaveforge_${filename}" "${S}/${filename}" || die
	done

	#octave_config_info is deprecated in octave5
	sed -i 's|octave_config_info|__octave_config_info__|g' Makefile || die

	chmod 0755 "${S}/configure" || die
	if [ -e "${S}/src/autogen.sh" ]; then
		pushd "${S}/src" || die
		 ./autogen.sh || die 'failed to run autogen.sh'
		popd || die
	fi
	if [ -e "${S}/src/Makefile" ]; then
		sed -i 's/ -s / /g' "${S}/src/Makefile" || die 'sed failed.'
	fi
	eapply_user
}

# @FUNCTION: octaveforge_src_install
# @DESCRIPTION:
# function to install the octave package
# documentation to docsdir
octaveforge_src_install() {
	emake DESTDIR="${D}" DISTPKG='Gentoo' install
	if [ -d doc/ ]; then
		dodoc -r doc/*
	fi
}

# @FUNCTION: octaveforge_pkg_postinst
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postinst() {
	einfo "Registering ${CATEGORY}/${PF} on the Octave package database."
	if [ ! -d "${OCT_PKGDIR}" ] ; then
		mkdir -p "${OCT_PKGDIR}" || die
	fi
	"${OCT_BIN}" -H -q --no-site-file --eval "pkg('rebuild');" &> /dev/null || die 'failed to register the package.'
}

# @FUNCTION: octaveforge_pkg_prerm
# @DESCRIPTION:
# function that will run on_uninstall routines to prepare the package to remove
octaveforge_pkg_prerm() {
	einfo 'Running on_uninstall routines to prepare the package to remove.'
	local pkgdir=$(
		"${OCT_BIN}" -H -q --no-site-file --eval "
			pkg('rebuild');
			l = pkg('list');
			disp(l{cellfun(@(x)strcmp(x.name,'${PN}'),l)}.dir);
		"
	)
	rm -f "${pkgdir}/packinfo/on_uninstall.m" || die
	if [ -e "${pkgdir}/packinfo/on_uninstall.m.orig" ]; then
		mv "$pkgdir"/packinfo/on_uninstall.m{.orig,} || die
		cd "$pkgdir/packinfo" || die
		"${OCT_BIN}" -H -q --no-site-file --eval "
			l = pkg('list');
			on_uninstall(l{cellfun(@(x)strcmp(x.name,'${PN}'), l)});
		" &> /dev/null || die 'failed to remove the package'
	fi
}

# @FUNCTION: octaveforge_pkg_postrm
# @DESCRIPTION:
# function that will rebuild the octave package database
octaveforge_pkg_postrm() {
	einfo 'Rebuilding the Octave package database.'
	if [ ! -d "${OCT_PKGDIR}" ] ; then
		mkdir -p "${OCT_PKGDIR}" || die
	fi
	"${OCT_BIN}" -H --silent --eval 'pkg rebuild' &> /dev/null || die 'failed to rebuild the package database'
}
