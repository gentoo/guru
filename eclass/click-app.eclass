# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: click-app.eclass
# @MAINTAINER:
# Anna <cyber+gentoo@sysrq.in>
# @AUTHOR:
# Anna <cyber+gentoo@sysrq.in>
# @SUPPORTED_EAPIS: 8
# @BLURB: eclass for Click-based Python applications
# @DESCRIPTION:
# This eclass provides a streamlined way to generate and install shell
# completions for Python applications based on the Click library
# (dev-python/click package).

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_CLICK_APP_ECLASS} ]]; then
_CLICK_APP_ECLASS=1

inherit distutils-r1 shell-completion

# @FUNCTION: click-app_enable_completions
# @USAGE: <script...>
# @DESCRIPTION:
# Set up IUSE, BDEPEND and python_install() to generate and install shell
# completions for the given scripts.
#
# This function does not overwrite python_install() if it is already defined.
# If you need to extend python_install(), you can call the original
# implementation as click-app_python_install.
#
# This function must be called in global scope.
#
# See also: https://click.palletsprojects.com/en/stable/shell-completion/
click-app_enable_completions() {
	debug-print-function "${FUNCNAME}" "${@}"
	(( $# >= 1 )) ||
		die "${FUNCNAME} takes at least one argument"

	IUSE+=" bash-completion"
	BDEPEND+=" bash-completion? ( ${RDEPEND} )"

	readonly -a _CLICK_SHELLCOMP_SCRIPTS=( "${@}" )

	click-app_python_install() {
		debug-print-function "${FUNCNAME}" "${@}"
		use bash-completion || return 0

		local script_name
		for script_name in "${_CLICK_SHELLCOMP_SCRIPTS[@]?}"; do
			click_install_completions "${script_name:?}"
		done
	}

	if ! declare -f python_install; then
		python_install() {
			click-app_python_install
			distutils-r1_python_install
		}
	fi

	# we need to ensure successful return in case we're called last,
	# otherwise Portage may wrongly assume sourcing failed
	return 0
}

# @FUNCTION: click-app_python_install
# @USAGE: <script...>
# @DESCRIPTION:
# Generate and install shell completions for the given scripts.
#
# Note that this function checks if USE="bash-completion" is enabled, and if
# not automatically exits. Therefore, there is no need to wrap this function
# in an "if" statement.
#
# This function needs to be called before distutils-r1_python_install.

# @FUNCTION: click_install_completions
# @USAGE: <script>
# @DESCRIPTION:
# Generate and install shell completions for a single script.
#
# Note that if a shell completions directory already exists in the install tree,
# generation and installation steps will be skipped for this shell.
#
# This function needs to be called before distutils-r1_python_install.
click_install_completions() {
	debug-print-function "${FUNCNAME}" "${@}"
	(( $# == 1 )) ||
		die "${FUNCNAME} takes exactly one argument"

	_gen_click_completions() {
		local shell=${1:?}

		echo "${env_var_name:?}=${shell:?}_source ${script_path:?}" >&2
		local -x "${env_var_name:?}"="${shell:?}_source" || die
		"${script_path:?}" || die
	}

	local env_var_name script_name script_path

	script_name=${1:?}
	script_path="${BUILD_DIR}/install${EPREFIX}/usr/bin/${script_name:?}"
	[[ -f "${script_path}" ]] ||
		die "${script_path} not found, click_install_completions call wrong"

	# convert to screaming snake case
	env_var_name="_${script_name:?}_COMPLETE"
	env_var_name=${env_var_name^^}
	env_var_name=${env_var_name//-/_}

	if [[ ! -d "${D}/$(get_bashcompdir)" ]]; then
		_gen_click_completions bash | newbashcomp - "${script_name:?}"
	fi
	if [[ ! -d "${D}/$(get_fishcompdir)" ]]; then
		_gen_click_completions fish | newfishcomp - "${script_name:?}.fish"
	fi
	if [[ ! -d "${D}/$(get_zshcompdir)" ]]; then
		_gen_click_completions zsh | newzshcomp - "_${script_name:?}"
	fi

	unset -f _gen_click_completions
}

fi
