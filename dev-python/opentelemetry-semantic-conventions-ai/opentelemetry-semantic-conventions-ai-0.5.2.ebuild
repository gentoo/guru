# Copyright 2026 Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PV=0.61.0
MY_P="openllmetry-${MY_PV}"
DESCRIPTION="OpenTelemetry Semantic Conventions for AI applications"
HOMEPAGE="
	https://github.com/traceloop/openllmetry
	https://pypi.org/project/opentelemetry-semantic-conventions-ai/
"
SRC_URI="
	https://github.com/traceloop/openllmetry/archive/refs/tags/v${MY_PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}/packages/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/opentelemetry-api-1.38.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-semantic-conventions-0.59_beta0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
