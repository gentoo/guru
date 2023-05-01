# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Apache Avro is a data serialization system"
HOMEPAGE="
	https://pypi.org/project/avro/
	https://avro.apache.org
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest
