# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
COMMIT="1ae9625e27ef47d2e6abc60156cd154cd1c37f46"

DESCRIPTION="Fancy, colorful theme with support for Powerline fonts"
HOMEPAGE="https://github.com/hauleth/agnoster"
SRC_URI="https://github.com/hauleth/agnoster/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-shells/fish"

S="${WORKDIR}/agnoster-${COMMIT}"
DOCS=( README.md )

src_install() {
	insinto "/usr/share/fish/vendor_conf.d"
	doins -r agnoster
	doins -r *.fish
	einstalldocs
}
