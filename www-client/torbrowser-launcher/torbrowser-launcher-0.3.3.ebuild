# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 optfeature xdg

DESCRIPTION="A program to download, updated, and run the Tor Browser Bundle"
HOMEPAGE="https://github.com/micahflee/torbrowser-launcher"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/micahflee/${PN}.git"
else
	SRC_URI="https://github.com/micahflee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="test"
LICENSE="MIT"
SLOT="0"
IUSE="apparmor"

RDEPEND="
	app-crypt/gpgme[python,${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP},widgets]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	apparmor? ( sys-libs/libapparmor )
"

PATCHES=(
	"${FILESDIR}/${PN}-distro.patch"
)

python_install_all() {
	distutils-r1_python_install_all

	# delete apparmor profiles
	if ! use apparmor; then
		rm -r "${D}/etc/apparmor.d" || die "Failed to remove apparmor profiles"
		rmdir "${D}/etc" || die "Failed to remove empty directory"
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "To get additional features, some optional runtime dependencies"
	elog "may be installed:"
	optfeature "updating over system TOR" net-vpn/tor dev-python/txsocksx
}
