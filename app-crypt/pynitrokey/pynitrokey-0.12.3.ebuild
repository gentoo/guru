# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 optfeature shell-completion

DESCRIPTION="A command line interface for the Nitrokey FIDO2, Start, 3 and NetHSM"
HOMEPAGE="https://github.com/Nitrokey/pynitrokey"

SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cffi-1.15[${PYTHON_USEDEP}]
	<dev-python/cffi-3[${PYTHON_USEDEP}]
	>=dev-python/click-8.2[${PYTHON_USEDEP}]
	<dev-python/click-9[${PYTHON_USEDEP}]
	>=dev-python/cryptography-43[${PYTHON_USEDEP}]
	<dev-python/cryptography-50[${PYTHON_USEDEP}]
	=dev-python/fido2-2*[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.14[${PYTHON_USEDEP}]
	=dev-python/intelhex-2*[${PYTHON_USEDEP}]
	>=dev-python/nitrokey-0.4.2[${PYTHON_USEDEP}]
	<dev-python/nitrokey-0.5[${PYTHON_USEDEP}]
	=dev-python/nkdfu-0.2*[${PYTHON_USEDEP}]
	=dev-python/pyusb-1*[${PYTHON_USEDEP}]
	=dev-python/requests-2*[${PYTHON_USEDEP}]
	=dev-python/tqdm-4*[${PYTHON_USEDEP}]
	=dev-python/tlv8-0.10*[${PYTHON_USEDEP}]
	=dev-python/semver-3*[${PYTHON_USEDEP}]
	>=dev-python/nethsm-2.1.1[${PYTHON_USEDEP}]
	<dev-python/nethsm-3[${PYTHON_USEDEP}]
"

# tests require a connected nitrokey device and will destroy the data on it!
# it would be bad if the user was not expecting this.
RESTRICT="test"

python_compile_all(){
	# https://github.com/Nitrokey/pynitrokey/blob/master/docs/packaging.md
	_NITROPY_COMPLETE=bash_source nitropy > nitropy.bash || die
	_NITROPY_COMPLETE=zsh_source nitropy > nitropy.zsh || die
	_NITROPY_COMPLETE=fish_source nitropy > nitropy.fish || die
}

python_install_all(){
	newbashcomp nitropy.bash nitropy
	newzshcomp nitropy.zsh _nitropy
	dofishcomp nitropy.fish

	distutils-r1_python_install_all
}

pkg_postinst(){
	optfeature "'piv' subcommand support" dev-python/pyscard
}
