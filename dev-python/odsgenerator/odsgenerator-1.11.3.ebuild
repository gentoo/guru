# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Generate an OpenDocument Format .ods file from a .json or .yaml file."
HOMEPAGE="https://github.com/jdum/odsgenerator"
SRC_URI="https://github.com/jdum/odsgenerator/archive/refs/tags/v${PV}.tar.gz -> odsgenerator-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
