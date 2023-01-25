# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Python implementation of the systemd sd_notify protocol"
HOMEPAGE="
	https://github.com/bb4242/sdnotify
	https://pypi.org/project/sdnotify/
"
SRC_URI="https://github.com/bb4242/${PN}/archive/refs/tags/v${PV}.tar.gz -> bb4242-${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_prepare_all() {
	# Fix QA warning.  No point in reporting upstream, the project seems abandoned
	sed 's/description-file/description_file/' -i setup.cfg

	distutils-r1_python_prepare_all
}
