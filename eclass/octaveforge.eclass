# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#
# Original Author: Rafael G. Martins <rafael@rafaelmartins.eng.br>
# Purpose: octaveforge helper eclass.
#

# @ECLASS-VARIABLE: OCTAVEFORGE_CAT
# @DESCRIPTION:
# the octave-forge category of the package.
OCTAVEFORGE_CAT="${OCTAVEFORGE_CAT:-main}"

REPO_URI="http://svn.code.sf.net/p/octave/code/trunk/octave-forge"

inherit autotools
SRC_URI="mirror://sourceforge/octave/${P}.tar.gz"

SRC_URI="
	${SRC_URI}
	${REPO_URI}/packages/package_Makefile.in -> octaveforge_Makefile
	${REPO_URI}/packages/package_configure.in -> octaveforge_configure
"
SLOT="0"

# defining some paths
OCT_ROOT="/usr/share/octave"
OCT_PKGDIR="${OCT_ROOT}/packages"
OCT_BIN="$(type -p octave)"

EXPORT_FUNCTIONS src_unpack src_prepare src_install pkg_postinst pkg_prerm pkg_postrm

octaveforge_src_unpack() {
	default
	if [ ! -d "${WORKDIR}/${P}" ]; then
		S="${WORKDIR}/${PN}"
		cd "${S}" || die
	fi
}

octaveforge_src_prepare() {
	for filename in Makefile configure; do
		cp "${DISTDIR}/octaveforge_${filename}" "${S}/${filename}" || die
	done

	#octave_config_info is deprecated in octave5
	sed -i 's|octave_config_info|__octave_config_info__|g' Makefile || die

	chmod 0755 "${S}/configure" || die
	if [ -e "${S}/src/autogen.sh" ]; then
		cd "${S}/src" && ./autogen.sh || die 'failed to run autogen.sh'
	fi
	if [ -e "${S}/src/Makefile" ]; then
		sed -i 's/ -s / /g' "${S}/src/Makefile" || die 'sed failed.'
	fi
	eapply_user
}

octaveforge_src_install() {
	emake DESTDIR="${D}" DISTPKG='Gentoo' install
	if [ -d doc/ ]; then
		dodoc -r doc/*
	fi
}

octaveforge_pkg_postinst() {
	einfo "Registering ${CATEGORY}/${PF} on the Octave package database."
	[ -d "${OCT_PKGDIR}" ] || mkdir -p "${OCT_PKGDIR}" || die
	"${OCT_BIN}" -H -q --no-site-file --eval "pkg('rebuild');" &> /dev/null || die 'failed to register the package.'
}

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

octaveforge_pkg_postrm() {
	einfo 'Rebuilding the Octave package database.'
	[ -d "${OCT_PKGDIR}" ] || mkdir -p "${OCT_PKGDIR}" || die
	"${OCT_BIN}" -H --silent --eval 'pkg rebuild' &> /dev/null || die 'failed to rebuild the package database'
}
