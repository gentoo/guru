# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install pkg_postinst

SLOT="0"
IUSE="byte-compile"

DEPEND="dev-lang/R"
RDEPEND="${DEPEND}"

dodocrm() {
	if [ -e "${1}" ]; then
		dodoc -r "${1}"
		rm -rf "${1}" || die
	fi
}

R-packages_src_unpack() {
	unpack ${A}
	if [[ -d "${PN//_/.}" ]] && [[ ! -d "${P}" ]]; then
		mv ${PN//_/.} "${P}"
	fi
}

R-packages_src_prepare() {
	rm -f LICENSE || die
	default
}


R-packages_src_compile() {
	MAKEFLAGS="CFLAGS=${CFLAGS// /\\ } CXXFLAGS=${CXXFLAGS// /\\ } FFLAGS=${FFLAGS// /\\ } FCFLAGS=${FCFLAGS// /\\ } LDFLAGS=${LDFLAGS// /\\ }" \
		R CMD INSTALL . -l "${WORKDIR}" $(use byte-compile && echo "--byte-compile")
}

R-packages_src_install() {
	cd "${WORKDIR}"/${PN//_/.} || die

	dodocrm examples || die
#	dodocrm DESCRIPTION || die #keep this
	dodocrm NEWS.md || die
	dodocrm README.md || die
	dodocrm html || die
	docinto "${DOCSDIR}/html"
	if [ -e doc ]; then
		ls doc/*.html &>/dev/null && dodoc -r doc/*.html
		rm -rf doc/*.html || die
		docinto "${DOCSDIR}"
		dodoc -r doc/.
		rm -rf doc
	fi

	insinto /usr/$(get_libdir)/R/site-library
	doins -r "${WORKDIR}"/${PN//_/.}
}

R-packages_pkg_postinst() {
	if [[ "${_UNRESOLVABLE_PACKAGES:-}" ]]; then
		# _UNRESOLVABLE_PACKAGES is only set if it has more than zero items
		local _max=${#_UNRESOLVABLE_PACKAGES[*]} i=

		einfo "Dependency(-ies):"
		for (( i=0; i<"${_max}"; i++ )); do
			einfo "- ${_UNRESOLVABLE_PACKAGES[$i]}"
		done
		einfo 'are (is) suggested by upstream but could not be found.'
		einfo 'Please install it manually from the R interpreter if you need it.'
	fi
}
