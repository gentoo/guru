# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-icon-picker.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-icon-picker/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK icon chooser with a text search option"
HOMEPAGE="https://github.com/nwg-piotr/nwg-icon-picker"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
