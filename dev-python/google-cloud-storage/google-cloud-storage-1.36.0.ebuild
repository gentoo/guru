# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Google Cloud Storage API client library"
HOMEPAGE="https://pypi.org/project/google-cloud-storage/"
SRC_URI="https://files.pythonhosted.org/packages/6d/5c/8f311c50661d907cbe5786c1be91ac75c59fdab4b69d8f679d0926b79820/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
