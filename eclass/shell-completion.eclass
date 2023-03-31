# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: shell-completion.eclass
# @SUPPORTED_EAPIS: 6 7 8
# @MAINTAINER:
# Jonas Frei <freijon@pm.me>
# @BLURB: A few quick functions to install various shell completion files
# @DESCRIPTION:
# This eclass provides a standardised way to install shell completions 
# for popular shells. It inherits the already widely adopted
# `bash-completion-r1`, thus extending on its functionality. 

if [[ ! ${_SHELL_COMPLETION_ECLASS} ]]; then
_SHELL_COMPLETION_ECLASS=1

# Extend bash-completion-r1
inherit bash-completion-r1

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} unsupported."
esac

# @FUNCTION: _shell-completion_get_fishcompdir
# @INTERNAL
# @DESCRIPTION:
# Get unprefixed fish completions directory
_shell-completion_get_fishcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo "/usr/share/fish/vendor_completions.d"
}

# @FUNCTION: _shell-completion_get_zshcompdir
# @INTERNAL
# @DESCRIPTION:
# Get unprefixed zsh completions directory
_shell-completion_get_zshcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo "/usr/share/zsh/site-functions"
}

# @FUNCTION: get_fishcompdir
# @DESCRIPTION:
# Get the fish completions directory.
get_fishcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo "${EPREFIX}$(_get_fishcompdir)"
}

# @FUNCTION: get_zshcompdir
# @DESCRIPTION:
# Get the zsh completions directory.
get_zshcompdir() {
	debug-print-function ${FUNCNAME} "${@}"

	echo "${EPREFIX}$(_get_zshcompdir)"
}

# @FUNCTION: dofishcomp
# @USAGE: <file> [...]
# @DESCRIPTION:
# Install fish completion files passed as args.
dofishcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insopts -m 0644
		insinto "$(_shell-completion_get_fishcompdir)"
		doins "${@}"
	)
}

# @FUNCTION: dozshcomp
# @USAGE: <file> [...]
# @DESCRIPTION:
# Install zsh completion files passed as args.
dozshcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insopts -m 0644
		insinto "$(_shell-completion_get_zshcompdir)"
		doins "${@}"
	)
}

# @FUNCTION: newfishcomp
# @USAGE: <file> <newname>
# @DESCRIPTION:
# Install fish file under a new name.
newfishcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insopts -m 0644
		insinto "$(_shell-completion_get_fishcompdir)"
		newins "${@}"
	)
}

# @FUNCTION: newzshcomp
# @USAGE: <file> <newname>
# @DESCRIPTION:
# Install zsh file under a new name.
newzshcomp() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insopts -m 0644
		insinto "$(_shell-completion_get_zshcompdir)"
		newins "${@}"
	)
}

fi
