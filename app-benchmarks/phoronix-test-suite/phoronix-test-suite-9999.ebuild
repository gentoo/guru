# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2034

EAPI=8

inherit bash-completion-r1 xdg-utils

DESCRIPTION="Phoronix's comprehensive, cross-platform testing and benchmark suite"
HOMEPAGE="http://www.phoronix-test-suite.com"

LICENSE="GPL-3"
SLOT="0"

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT3_STORE_DIR="${T}"
inherit git-r3
SRC_URI=""

IUSE="sdl"

RDEPEND="${DEPEND}
		app-arch/p7zip
		media-libs/libpng
		>=dev-lang/php-5.3[cli,curl,gd,posix,pcntl,sockets,ssl,truetype,xml,zip,zlib]
		www-servers/apache
		x11-base/xorg-server
		sdl? (
			media-libs/libsdl
			media-libs/sdl-net
			media-libs/sdl-image
			media-libs/libsdl2
			media-libs/sdl2-net
			media-libs/sdl2-image
			media-libs/sdl2-mixer

		)"

check_php_config()
{
	local slot
	for slot in $(eselect --brief php list cli); do
		local php_dir="/etc/php/cli-${slot}"

		if [[ -f "${EROOT%}/${php_dir}/php.ini" ]]; then
			dodir "${php_dir}"
			cp -f "${EROOT%}/${php_dir}/php.ini" "${ED%}/${php_dir}/php.ini" \
					|| die "cp failed: copy php.ini file"
			sed -i -e 's|^allow_url_fopen .*|allow_url_fopen = On|g' "${ED%}/${php_dir}/php.ini" \
					|| die "sed failed: modify php.ini file"
		elif [[ "$(eselect php show cli)" == "${slot}" ]]; then
			ewarn "${slot} does not have a php.ini file."
			ewarn "${PN} needs the 'allow_url_fopen' option set to \"On\""
			ewarn "for downloading to work properly."
			ewarn
		else
			elog "${slot} does not have a php.ini file."
			elog "${PN} may need the 'allow_url_fopen' option set to \"On\""
			elog "for downloading to work properly if you switch to ${slot}"
			elog
		fi
	done
}

get_optional_dependencies()
{
	(($# == 1)) || die "${FUNCNAME[0]}(): invalid number of arguments: ${#} (1)"

	local -a array_package_names
	local field_value ifield package_generic_name optional_packages_xmlline package_names installable_packages=""
	local package_close_regexp="</Package>" \
		  package_generic_name_regexp="^.*<GenericName>|</GenericName>.*$" \
		  package_names_regexp="^.*<PackageName>|</PackageName>.*$"

	line=0
	while IFS=$'\n' read -r optional_packages_xmlline; do
		if [[ "${optional_packages_xmlline}" =~ ${package_generic_name_regexp} ]]; then
			package_generic_name="$(echo "${optional_packages_xmlline}" | sed -r "s@${package_generic_name_regexp}@@g")"
		elif [[ "${optional_packages_xmlline}" =~ ${package_names_regexp} ]]; then
			package_names="$(echo "${optional_packages_xmlline}" | sed -r -e "s@${package_names_regexp}@@g" -e 's@(^[[:blank:]]+|[[:blank:]]+$)$@@g' )"
			ifield=0
			# shellcheck disable=SC2206
			array_package_names=( ${package_names} )
			for (( ifield=0 ; ifield < ${#array_package_names[@]} ; ++ifield )); do
				field_value="${array_package_names[ifield]}"
				[[ ${field_value} =~ ^.+/.+$ ]]	|| continue	# skip invalid package atoms

				if ! has_version "${field_value}"; then
					installable_packages="${installable_packages}${installable_packages:+ }${field_value}"
				fi
			done
		elif [[ "${optional_packages_xmlline}" =~ ${package_close_regexp} && -n "${installable_packages}" ]]; then
			ewarn "  ${package_generic_name}: ${installable_packages}"
			installable_packages=""
		fi
	done <<< "${1}"
}

src_prepare() {
	# BASH completion helper function "have" test is depreciated
	sed -i -e '/^have phoronix-test-suite &&$/d' "${S}/pts-core/static/bash_completion" \
			|| die "sed failed: remove PTS bash completion have test"
	# Remove all dependency resolving shell scripts - security vulnerability
	rm -rf "${S}/pts-core/external-test-dependencies/scripts"
	eapply_user
}

src_install() {
	# Store the contents of this file - since it will be installed / deleted before we need it.
	GENTOO_OPTIONAL_PKGS_XML="$(cat "${S}/pts-core/external-test-dependencies/xml/gentoo-packages.xml")"
	newbashcomp pts-core/static/bash_completion "${PN}"
	DESTDIR="${D}" "${S}/install-sh" "${EPREFIX%}/usr"

	# Fix the cli-php config for downloading to work.
	check_php_config
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update

	ewarn "${PN} has the following optional package dependencies:"
	get_optional_dependencies "${GENTOO_OPTIONAL_PKGS_XML}"
	unset -v GENTOO_OPTIONAL_PKGS_XML
}
