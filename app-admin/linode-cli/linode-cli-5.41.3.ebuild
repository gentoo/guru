# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Linode Command Line Interface"
HOMEPAGE="https://github.com/linode/linode-cli https://www.linode.com/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/boto3
	dev-python/packaging
	dev-python/pyyaml
	dev-python/requests
	dev-python/rich
	<dev-python/urllib3-3
"
