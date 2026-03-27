# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

# See https://github.com/openai/openai-python/blob/main/.stats.yml
API_SPEC_BASE="https://storage.googleapis.com/stainless-sdk-openapi-specs"
API_SPEC="openai-openapi-spec-v2.3.0.yml"
MY_PN="openai-python"
STDY_PV=0.19.7
DESCRIPTION="The official Python library for the openai API"
HOMEPAGE="
	https://github.com/openai/openai-python
	https://pypi.org/project/openai/
"
SRC_URI="
	https://github.com/openai/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_PN}-${PV}.gh.tar.gz

	test? (
		${API_SPEC_BASE}/openai%2Fopenai-00994178cc8e20d71754b00c54b0e4f5b4128e1c1cce765e9b7d696bd8c80d33.yml
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

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/anyio-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/httpx-aiohttp[${PYTHON_USEDEP}]
		net-libs/nodejs[npm]
		net-misc/curl
	)
"

EPYTEST_PLUGINS=(
	inline-snapshot
	nest-asyncio
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

	cp "${FILESDIR}/${PN}-2.29.0-mock-server-package.json" \
		"${mock_dir}/package.json" || die
	cp "${FILESDIR}/${PN}-2.29.0-mock-server-package-lock.json" \
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

	local attempts=0
	while ! curl -sf "http://127.0.0.1:4010/_x-steady/health" &>/dev/null; do
		if ! kill -0 ${mock_pid} 2>/dev/null; then
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

	popd >/dev/null || die

	nonfatal distutils-r1_src_test
	local ret=${?}

	einfo "Stopping mock server..."
	kill "${mock_pid}" || die

	[[ ${ret} -ne 0 ]] && die
}

python_test() {
	epytest -o asyncio_mode=auto
}
