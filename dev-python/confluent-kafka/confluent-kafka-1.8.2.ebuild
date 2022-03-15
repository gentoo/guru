# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN}-python"
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Confluent's Kafka Python Client"
HOMEPAGE="
	https://pypi.org/project/confluent-kafka/
	https://github.com/confluentinc/confluent-kafka-python
"
SRC_URI="https://github.com/confluentinc/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/librdkafka
	>=dev-python/fastavro-1.0[${PYTHON_USEDEP}]
	>=dev-python/avro-1.10.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyrsistent[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
