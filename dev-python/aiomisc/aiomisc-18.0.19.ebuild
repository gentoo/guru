# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="aiomisc - miscellaneous utils for asyncio"
HOMEPAGE="
	https://github.com/aiokitchen/aiomisc
	https://pypi.org/project/aiomisc/
"

MY_COMMIT="ebfdb45c8d60fda24e42f7589d2fc7fe11ae4f0c" # v18.0.9 (untagged, inferred)
SRC_URI="https://github.com/aiokitchen/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/caio-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/rich-12.6[${PYTHON_USEDEP}]
		>=dev-python/setproctitle-1.3[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( aiomisc-pytest )
EPYTEST_XDIST=1
distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_AIOMISC=${PV}

EPYTEST_IGNORE=(
	# Missing dependencies
	tests/test_carbon_service.py # aiocarbon
	tests/test_dns.py # dnslib
	tests/test_dns_server.py # dnslib
	tests/test_entrypoint.py # various
	tests/test_raven_service.py # raven
)

EPYTEST_DESELECT=(
	# Broken (race conditions)
	tests/test_thread_pool.py::test_from_thread_channel
	tests/test_thread_pool.py::test_from_thread_channel_wait_before
)

pkg_postinst() {
	optfeature "aiohttp" dev-python/aiohttp
	# optfeature "ASGI" dev-python/aiohttp-asgi
	# optfeature "Carbon" dev-python/aiocarbon
	optfeature "cron" dev-python/croniter
	# optfeature "DNS" dev-python/dnslib
	# optfeature "gRPC" "dev-python/grpcio dev-python/grpcio-tools dev-python/grpcio-reflection"
	# optfeature "Raven" "dev-python/aiohttp dev-python/raven"
	optfeature "uvicorn" "dev-python/uvicorn dev-python/asgiref"
	optfeature "uvloop" dev-python/uvloop

	optfeature_header "For additional logging features install:"
	optfeature "clorized log output with Rich" dev-python/rich
	# optfeature "log output to systemd journald" dev-python/logging-journald
}
