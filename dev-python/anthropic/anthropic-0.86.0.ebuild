# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

# See https://github.com/anthropics/anthropic-sdk-python/blob/main/.stats.yml
API_SPEC_BASE="https://storage.googleapis.com/stainless-sdk-openapi-specs"
API_SPEC="anthropic-openapi-spec-v2026.03.18.yml"
MY_PN="anthropic-sdk-python"
STDY_PV=0.19.7
DESCRIPTION="The official Python library for the anthropic API"
HOMEPAGE="
	https://github.com/anthropics/anthropic-sdk-python
	https://pypi.org/project/anthropic
"
SRC_URI="
	https://github.com/anthropics/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_PN}-${PV}.gh.tar.gz

	test? (
		${API_SPEC_BASE}/anthropic%2Fanthropic-dd2dcd00a757075370a7e4a7f469a1e2d067c2118684c3b70d7906a8f5cf518b.yml
			-> ${API_SPEC}

		https://registry.npmjs.org/@stdy/cli/-/cli-${STDY_PV}.tgz
			-> npm-@stdy-cli-cli-${STDY_PV}.tgz

		amd64? (
			https://registry.npmjs.org/@stdy/cli-linux-x64/-/cli-linux-x64-${STDY_PV}.tgz
				-> npm-@stdy-cli-linux-x64-cli-linux-x64-${STDY_PV}.tgz
		)

		arm64? (
			https://registry.npmjs.org/@stdy/cli-linux-arm64/-/cli-linux-arm64-${STDY_PV}.tgz
				-> npm-@stdy-cli-linux-arm64-cli-linux-arm64-${STDY_PV}.tgz
		)
	)
"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/anyio-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		>=dev-python/boto3-1.28.57[${PYTHON_USEDEP}]
		>=dev-python/botocore-1.31.57[${PYTHON_USEDEP}]
		dev-python/httpx-aiohttp[${PYTHON_USEDEP}]
		>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
		net-libs/nodejs[npm]
		net-misc/curl
	)
"

EPYTEST_PLUGINS=(
	dirty-equals
	http-snapshot
	inline-snapshot
	pytest-{asyncio,xdist}
	respx
	time-machine
)
distutils_enable_tests pytest

src_unpack() {
	unpack "${MY_PN}-${PV}.gh.tar.gz"
}

src_test() {
	einfo "Assembling npm cache..."

	local -x npm_config_cache="${WORKDIR}/npm-cache"
	mkdir -p "${npm_config_cache}" || die

	for distfile in ${A}; do
		if [[ "${distfile}" == npm-* ]]; then
			npm cache add "${DISTDIR}/${distfile}" &>/dev/null || die
		fi
	done

	einfo "Installing mock server..."

	local mock_dir="${WORKDIR}/mock-server"
	mkdir -p "${mock_dir}" || die

	cp "${FILESDIR}/${PN}-0.86.0-mock-server-package.json" \
		"${mock_dir}/package.json" || die
	cp "${FILESDIR}/${PN}-0.86.0-mock-server-package-lock.json" \
		"${mock_dir}/package-lock.json" || die

	local mock_dir="${WORKDIR}/mock-server"
	local mock="${mock_dir}/node_modules/.bin/steady"

	pushd "${mock_dir}" >/dev/null || die

	npm ci &>/dev/null || die

	einfo "Starting mock server..."

	# Replicate the logic from scripts/mock --daemon
	"${mock}" --host 127.0.0.1 -p 4010 \
		--validator-form-array-format=brackets \
		--validator-query-array-format=brackets \
		--validator-form-object-format=brackets \
		--validator-query-object-format=brackets \
		"${DISTDIR}/${API_SPEC}" &> .stdy.log &
	local mock_pid=$!

	is_mock_running() {
		local -a args
		readarray -d '' args < "/proc/${mock_pid}/cmdline" 2>/dev/null || return 1
		[[ "${args[1]}" == "${mock}" ]]
	}

	local attempts=0
	while ! curl -sf "http://127.0.0.1:4010/_x-steady/health" &>/dev/null; do
		if ! is_mock_running; then
			cat .stdy.log
			die "Mock server failed to start"
		fi
		attempts=$((attempts + 1))
		if (( attempts >= 300 )); then
			cat .stdy.log
			die "Timed out waiting for mock server to start"
		fi
		sleep 0.1
	done

	# Oops; connected to another Steady instance running on 4010
	is_mock_running || die

	popd >/dev/null || die

	nonfatal distutils-r1_src_test
	local ret=${?}

	if is_mock_running; then
		einfo "Stopping mock server..."
		kill "${mock_pid}" || die
	fi

	[[ ${ret} -ne 0 ]] && die
}

pkg_postinst() {
	optfeature "alternative async HTTP client support" \
		"dev-python/aiohttp >=dev-python/httpx-aiohttp-0.1.9"
	optfeature "Google Cloud Vertex AI integration" \
		">=dev-python/google-auth-2 dev-python/requests"
	optfeature "Amazon Web Services (AWS) Bedrock integration" \
		">=dev-python/boto3-1.28.57 >=dev-python/botocore-1.31.57"
	optfeature "Model Context Protocol (MCP) support" \
		">=dev-python/mcp-1.0"
}
