# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 xdg-utils

DESCRIPTION="Krapplet (keyring applet): a password manager based on gnome-keyring."
HOMEPAGE="https://gitlab.com/hfernh/krapplet https://pypi.org/project/krapplet"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~x86"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND=${PYTHON_DEPS}
BDEPEND=${RDEPEND}

# Upstream does not provide any test suite.
RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	x11-libs/gtk+:3
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-python/secretstorage "

DEPEND="${RDEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
