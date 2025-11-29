EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="GUI wallpaper setter for Wayland and Xorg window managers"
HOMEPAGE="https://github.com/anufrievroman/waypaper"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/imageio-ffmpeg[${PYTHON_USEDEP}]
	dev-python/screeninfo[${PYTHON_USEDEP}]
"
