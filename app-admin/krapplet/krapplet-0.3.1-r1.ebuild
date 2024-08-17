# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi xdg

DESCRIPTION="Krapplet (keyring applet): a Linux graphical password manager"
HOMEPAGE="
	https://gitlab.com/hfernh/krapplet
	https://pypi.org/project/krapplet/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64"
IUSE="+gnome-keyring pass"
REQUIRED_USE="|| ( gnome-keyring pass )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	gnome-keyring? ( dev-python/secretstorage[${PYTHON_USEDEP}] )
	pass? ( dev-python/python-gnupg[${PYTHON_USEDEP}] )
"
