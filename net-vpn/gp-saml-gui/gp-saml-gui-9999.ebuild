# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 git-r3

DESCRIPTION="Interactively authenticate to GlobalProtect VPNs that require SAML"
HOMEPAGE="https://github.com/dlenski/gp-saml-gui"

EGIT_REPO_URI="https://github.com/dlenski/gp-saml-gui.git"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	net-libs/webkit-gtk:4.1
	net-vpn/openconnect
"
