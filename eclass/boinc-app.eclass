# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: boinc-app.eclass
# @MAINTAINER:
# Anna Vyalkova <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: base functions for installing BOINC applications
# @DESCRIPTION:
# This eclass provides base functions for installation of software developed
# for the BOINC platform.
#
# Do not package *-bin applications as BOINC can handle them itself better.
#
# Note that BOINC won't detect a custom application unless you provide it with
# app_info.xml file (see https://boinc.berkeley.edu/wiki/Anonymous_platform).
# Attach to a project of your interest and use values from
# /var/lib/boinc/client_state.xml to write the file.
#
# BOINC.Italy did a great job discovering sources of many BOINC applications:
# https://www.boincitaly.org/progetti/sorgenti-progetti.html

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} unsupported"
esac

# @ECLASS_VARIABLE: BOINC_APP_OPTIONAL
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# If set to a non-null value, BOINC part in the ebuild will be
# considered optional and no phase functions will be exported.
#
# If you enable BOINC_APP_OPTIONAL, you have to call boinc-app
# default phase functions and add dependencies manually.

if [[ ! ${_BOINC_APP_ECLASS} ]]; then

# @ECLASS_VARIABLE: BOINC_MASTER_URL
# @REQUIRED
# @DESCRIPTION:
# Each project is publicly identified by a master URL. It also serves
# as the home page of the project.
#
# You need to look it up using the following command:
# @CODE
#	grep "<master_url>" /var/lib/boinc/client_state.xml
# @CODE

# @ECLASS_VARIABLE: BOINC_INVITATION_CODE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Some projects restrict account creation to those who present an
# "invitation code". Write it to BOINC_INVITATION_CODE variable if
# it's published on project's website.

# @ECLASS_VARIABLE: HOMEPAGE
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# This variable defines the HOMEPAGE for BOINC projects if BOINC_MASTER_URL
# was set before inherit.
: ${HOMEPAGE:=${BOINC_MASTER_URL}}

# @ECLASS_VARIABLE: BOINC_APP_HELPTEXT
# @DESCRIPTION:
# Help message to display during the pkg_postinst phase
: ${BOINC_APP_HELPTEXT:=\
You have to attach to the corresponding project
in order to use this application with BOINC.}

# @ECLASS_VARIABLE: BOINC_RUNTIMEDIR
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Directory with BOINC runtime data.

# @FUNCTION: boinc-app_add_deps
# @USAGE: [--wrapper]
# @DESCRIPTION:
# Generate appropriate IUSE and (R)DEPEND for wrapper-enabled or
# native application.
#
# If BOINC_APP_OPTIONAL is set to a non-null value, dependencies
# will be added for "boinc" USE-flag.
boinc-app_add_deps() {
	debug-print-function ${FUNCNAME} "${@}"

	local depend rdepend
	if [[ ${1} == "--wrapper" ]]; then
		rdepend="sci-misc/boinc-wrapper"
	else
		depend="sci-misc/boinc"
		rdepend="sci-misc/boinc"
	fi

	depend+=" acct-user/boinc"
	rdepend+=" acct-user/boinc"

	if [[ ${BOINC_APP_OPTIONAL} ]]; then
		IUSE+=" boinc"
		DEPEND+=" boinc? ( ${depend} )"
		RDEPEND+=" boinc? ( ${rdepend} )"
	else
		DEPEND+=" ${depend}"
		RDEPEND+=" ${rdepend}"
	fi
}

# @FUNCTION: get_boincdir
# @RETURN: non-prefixed BOINC runtime directory
get_boincdir() {
	echo "${BOINC_RUNTIMEDIR:-/var/lib/boinc}"
}

# @FUNCTION: get_project_dirname
# @INTERNAL
# @RETURN: project's dirname, derived from BOINC_MASTER_URL
# @DESCRIPTION:
# Example:
#
# @CODE
# BOINC_MASTER_URL="https://boinc.berkeley.edu/example/"
# get_project_dirname
# -> boinc.berkeley.edu_example
# @CODE
get_project_dirname() {
	[[ ${BOINC_MASTER_URL} ]] || \
		die "BOINC_MASTER_URL is not set"

	local dirname
	dirname=${BOINC_MASTER_URL#*://}	# strip http[s]://
	dirname=${dirname%/}			# strip trailing slash
	dirname=${dirname////_}			# replace '/' with '_'

	echo "${dirname}"
}

# @FUNCTION: get_project_root
# @RETURN: non-prefixed directory where applications and files should be installed
get_project_root() {
	echo "$(get_boincdir)/projects/$(get_project_dirname)"
}

# @FUNCTION: _boinc-app_fix_permissions
# @INTERNAL
# @DESCRIPTION:
# Fix owner and permissions for the project root.
_boinc-app_fix_permissions() {
	local paths=(
		$(get_boincdir)
		$(get_boincdir)/projects
		$(get_project_root)
	)
	fowners boinc:boinc "${paths[@]}"
	fperms 0771 "${paths[@]}"
}

# @FUNCTION: boinc-app_appinfo_prepare
# @USAGE: <app_info>
# @DESCRIPTION:
# The default appinfo_prepare(). It replaces all occurences
# of @PV@ with its corresponding value.
boinc-app_appinfo_prepare() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# == 1 )) || \
		die "${FUNCNAME} takes exactly one argument"

	sed -i "${1:?}" \
		-e "s:@PV@:${PV}:g" \
		|| die "app_info.xml sed failed"
}

# @FUNCTION: boinc_install_appinfo
# @USAGE: <app_info>
# @DESCRIPTION:
# Installs given app_info.xml file to the project root.
#
# Tip: implement appinfo_prepare() function for all your sed hacks.
# It should recognize first argument as a file and edit it in place.
#
# Example:
# @CODE
# appinfo_prepare() {
# 	if ! use cuda; then
# 		sed "/<plan_class>cuda/d" -i "$1" || die
# 	fi
# 	boinc-app_appinfo_prepare "$1"
# }
#
# src_install() {
# 	boinc_install_appinfo "${FILESDIR}"/app_info_1.0.xml
#
#	exeinto $(get_project_root)
# 	exeopts -m 0755 --owner root --group boinc
# 	newexe bin/${PN} example_app_v1.0
# }
# @CODE
boinc_install_appinfo() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# == 1 )) || \
		die "${FUNCNAME} takes exactly one argument"

	cp "${1:?}" "${T:?}"/app_info.xml || die

	if declare -f appinfo_prepare >/dev/null; then
		appinfo_prepare "${T:?}"/app_info.xml
	else
		boinc-app_appinfo_prepare "${T:?}"/app_info.xml
	fi

	( # subshell to avoid pollution of calling environment
		insinto "$(get_project_root)"
		insopts -m 0644 --owner root --group boinc
		doins "${T:?}"/app_info.xml
	) || die "failed to install app_info.xml"

	_boinc-app_fix_permissions
}

# @FUNCTION: doappinfo
# @DEPRECATED: boinc_install_appinfo
# @USAGE: <app_info>
# @DESCRIPTION:
# Installs given app_info.xml file to the project root.
doappinfo() {
	boinc_install_appinfo "${@}"
}

# @FUNCTION: boinc-app_foreach_wrapper_job
# @USAGE: <job>
# @DESCRIPTION:
# The default foreach_wrapper_job(). It replaces all occurences
# of @PV@, @EPREFIX@ and @LIBDIR@ strings with their corresponding values.
boinc-app_foreach_wrapper_job() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# == 1 )) || \
		die "${FUNCNAME} takes exactly one argument"

	sed -i "${1:?}" \
		-e "s:@PV@:${PV}:g" \
		-e "s:@EPREFIX@:${EPREFIX}:g" \
		-e "s:@LIBDIR@:$(get_libdir):g" \
		|| die "$(basename "${1}") sed failed"
}

# @FUNCTION: boinc_install_wrapper
# @USAGE: <bin> <job> [new name]
# @DESCRIPTION:
# This function provides a uniform way to install wrapper applications
# for BOINC projects. It makes symlinks to the BOINC wrapper and also
# installs respective job.xml files.
#
# When `dowrapper boinc-example_wrapper A.xml B.xml` is called, it:
#
# 1. Installs A.xml in the project's root directory, renaming it to B.xml
#
# 2. Installs boinc-example_wrapper symlink, which points
#    to /usr/bin/boinc-wrapper, in the project's root directory
#
# Example:
# @CODE
# src_install() {
# 	meson_src_install
#
# 	boinc_install_wrapper boinc-example_wrapper "${FILESDIR}"/job.xml
#	boinc_install_appinfo "${FILESDIR}"/app_info_1.0.xml
# }
# @CODE
#
# Keep your job.xml files in sync with app_info.xml!
boinc_install_wrapper() {
	debug-print-function ${FUNCNAME} "${@}"

	(( $# >= 2 && $# <= 3 )) || \
		die "${FUNCNAME} got wrong number of arguments"

	local exe="${1:?}"
	local job="${2:?}"
	local job_dest="${3:-$(basename "${job:?}")}"

	cp "${job:?}" "${T:?}/${job_dest:?}" || die
	if declare -f foreach_wrapper_job >/dev/null; then
		foreach_wrapper_job "${T:?}/${job_dest:?}"
	else
		boinc-app_foreach_wrapper_job "${T:?}/${job_dest:?}"
	fi

	( # subshell to avoid pollution of calling environment
		insinto "$(get_project_root)"
		insopts -m 0644 --owner root --group boinc
		doins "${T:?}/${job_dest:?}"
	) || die "failed to install ${exe:?} wrapper job"
	rm -f "${T:?}/${job_dest:?}"

	dosym -r /usr/bin/boinc-wrapper "$(get_project_root)/${exe:?}"
	_boinc-app_fix_permissions
}

# @FUNCTION: dowrapper
# @DEPRECATED: boinc_install_wrapper
# @DESCRIPTION:
# Install BOINC wrappers and job definitions.
dowrapper() {
	die "${FUNCNAME} has been removed, please use boinc_install_wrapper instead"
}

# @FUNCTION: boinc-app_pkg_postinst
# @DESCRIPTION:
# Display helpful instructions on how to make the BOINC client use installed
# applications.
boinc-app_pkg_postinst() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ -f "${EROOT}/$(get_boincdir)/master_$(get_project_dirname).xml" ]]; then
		if [[ ! ${REPLACING_VERSIONS} ]]; then
			# most likely replacing applications downloaded
			# by the BOINC client from project's website
			elog "Restart the BOINC daemon for changes to take place:"
			elog "# rc-service boinc restart"
		fi
		return
	fi

	elog
	while read h; do
		elog "${h}"
	done <<<"${BOINC_APP_HELPTEXT}"
	elog

	if [[ ! ${BOINC_INVITATION_CODE} ]]; then
		elog "# rc-service boinc attach"
		elog "    Enter the Project URL: ${BOINC_MASTER_URL:?}"
	else
		elog "- Master URL: ${BOINC_MASTER_URL:?}"
		elog "- Invitation code: ${BOINC_INVITATION_CODE:?}"
	fi
}

# @FUNCTION: boinc-app_pkg_postrm
# @DESCRIPTION:
# Display helpful instructions on how to cleanly uninstall unmerged
# applications.
boinc-app_pkg_postrm() {
	debug-print-function ${FUNCNAME} "${@}"

	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		local gui_rpc_auth="$(get_boincdir)/gui_rpc_auth.cfg"
		local passwd=$(cat "${EROOT}/${gui_rpc_auth}" 2>/dev/null)
		if [[ ! ${passwd?} ]]; then
			passwd="\$(cat ${gui_rpc_auth:?})"
		fi

		elog "You should detach this project from the BOINC client"
		elog "to stop current tasks and delete remaining project files:"
		elog
		elog "$ boinccmd --passwd ${passwd:?} --project ${BOINC_MASTER_URL:?} detach"
		elog
	fi
}

_BOINC_APP_ECLASS=1
fi

if [[ ! ${BOINC_APP_OPTIONAL} ]]; then
	EXPORT_FUNCTIONS pkg_postinst pkg_postrm
fi
