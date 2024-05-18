# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of the systemd sd_notify protocol"
HOMEPAGE="
	https://github.com/bb4242/sdnotify
	https://pypi.org/project/sdnotify/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_prepare_all() {
	# Fix QA warning.  No point in reporting upstream, the project seems abandoned
	sed 's/description-file/description_file/' -i setup.cfg

	distutils-r1_python_prepare_all
}
