# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Send usage data from your Python code to PostHog"
HOMEPAGE="
	https://github.com/PostHog/posthog-python
	https://pypi.org/project/posthog/
"
SRC_URI="https://github.com/PostHog/posthog-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/posthog-python-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/backoff[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	"posthog/test/test_consumer.py::TestConsumer::test_request"
	"posthog/test/test_consumer.py::TestConsumer::test_upload"
	"posthog/test/test_exception_capture.py::test_excepthook"
	"posthog/test/test_feature_flags.py::TestLocalEvaluation::test_load_feature_flags_wrong_key"
	"posthog/test/test_request.py::TestRequests::test_should_not_timeout"
	"posthog/test/test_request.py::TestRequests::test_should_timeout"
	"posthog/test/test_request.py::TestRequests::test_valid_request"
)

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
