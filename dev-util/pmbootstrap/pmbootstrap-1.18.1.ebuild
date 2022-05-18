# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/c8/9f/3c542d12c2c84e50f52b8614adbdc8e2094174aebaf169fef291219af882/pmbootstrap-1.18.1.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
