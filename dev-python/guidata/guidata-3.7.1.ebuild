# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Library for user interfaces for easy dataset editing and display"
HOMEPAGE="https://pypi.org/project/guidata/"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test +pyqt5 pyqt6"

REQUIRED_USE="|| ( pyqt5 pyqt6 )"

RDEPEND="
	pyqt5? ( dev-python/PyQt5[${PYTHON_USEDEP}] )
	pyqt6? ( dev-python/PyQt6[${PYTHON_USEDEP}] )

	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pytest-qt[${PYTHON_USEDEP}]
		dev-python/pytest-xvfb[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest -p xvfb
}
