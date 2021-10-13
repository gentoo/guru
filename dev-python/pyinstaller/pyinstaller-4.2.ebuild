# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend

PYTHON_COMPAT=( python3_{8,9} )
inherit distutils-r1

DESCRIPTION="Bundles a Python application and all its dependencies into a single package."
HOMEPAGE="https://pypi.org/project/pyinstaller/"
SRC_URI="https://files.pythonhosted.org/packages/b4/83/9f6ff034650abe9778c9a4f86bcead63f89a62acf02b1b47fc2bfc6bf8dd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

QA_PRESTRIPPED="usr/lib/python.*/site-packages/PyInstaller/bootloader/Linux-.*/run.*"
