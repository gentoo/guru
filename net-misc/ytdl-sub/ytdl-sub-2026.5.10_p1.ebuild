# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Automate downloading and metadata generation with yt-dlp"
HOMEPAGE="
	https://github.com/jmbannon/ytdl-sub
	https://pypi.org/project/ytdl-sub/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=net-misc/yt-dlp-2026.03.17
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/mediafile[${PYTHON_USEDEP}]
	dev-python/mergedeep[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
