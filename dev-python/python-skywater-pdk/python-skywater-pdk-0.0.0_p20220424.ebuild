# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )

MY_PN="skywater-pdk"
MY_REV=5a57f505cd4cd65d10e9f37dd2d259a526bc9bf7

inherit distutils-r1

DESCRIPTION="Python library for working with files found in the SkyWater PDK"
HOMEPAGE="https://github.com/google/skywater-pdk"
SRC_URI="https://github.com/google/skywater-pdk/archive/${MY_REV}.tar.gz -> skywater-pdk-${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_REV}/scripts/python-skywater-pdk"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/dataclasses-json[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	sed '/sample/d' -i setup.py || die
	distutils-r1_src_prepare
}
