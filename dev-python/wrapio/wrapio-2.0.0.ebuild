# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="Handling event-based streams in Python"
HOMEPAGE="
	https://github.com/Exahilosys/wrapio
	https://pypi.org/project/wrapio/
	"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
