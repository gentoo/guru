# Copyright 2026 Gentoo Authors
# Distributed under the terms of the Apache License 2.0

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="The agentic frontend framework that even humans can use"
HOMEPAGE="
	https://prefab.prefect.io/
	https://github.com/PrefectHQ/prefab
	https://pypi.org/project/prefab-ui/
"

# prefab-ui uses Pyodide (Wasm CPython) within Deno for its sandbox.
# We vendor both the Deno runtime dependencies and the Wasm Python wheels
# to allow the test suite to execute inside the Portage network sandbox.
#
# Sandbox vendor tarball contents and checksums generated via:
# src/prefab_ui/sandbox $ deno cache --vendor --lock=deno.lock runner.js
# ... and:
# $ u="https://cdn.jsdelivr.net/pyodide/v0.27.4/full"; \
# mkdir pyodide_packages && cd pyodide_packages && wget -q "$u/pyodide-lock.json" && \
# python -c 'import json, sys; pkgs=set(sys.argv[1].split()); f=sys.stderr; \
# [(print(v["file_name"]), f.write(v["sha256"] + "  " + v["file_name"] + "\n")) \
# for k, v in json.load(sys.stdin)["packages"].items() if k in pkgs]' \
# "annotated-types pydantic pydantic-core typing-extensions" \
# <pyodide-lock.json 2>../checksums.sha256 | xargs -I {} wget -q "$u/{}"

# Vendored test dependencies
VD_TAG=2026.03.28.0
VD_BASE_URI="https://github.com/falbrechtskirchinger/overlay-assets/releases/download"
SRC_URI+="
	test? (
		${VD_BASE_URI}/v${VD_TAG}/${PN//-/_}-sandbox-v${VD_TAG%.*}.tar.xz
		${VD_BASE_URI}/v${VD_TAG}/${PN//-/_}-pyodide-v${VD_TAG%.*}.sha256
	)
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	dev-lang/deno-bin
	>=dev-python/pydantic-2.11[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-4[${PYTHON_USEDEP}]
	>=dev-python/rich-13[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/jsonschema[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,timeout} )
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_test() {
	local -x DENO_NO_REMOTE=1

	# Check cache completness
	pushd ..>/dev/null || die
	echo '{"vendor": true}' >deno.json || die
	deno cache --lock=deno.lock --frozen \
		"${S}/src/prefab_ui/sandbox/runner.js" || die
	popd >/dev/null || die

	# Verify vendored wheels
	pushd "${WORKDIR}/pyodide_packages" >/dev/null || die
	sha256sum -c "${DISTDIR}/${PN//-/_}-pyodide-v${VD_TAG%.*}.sha256" || die
	popd >/dev/null || die

	distutils-r1_src_test
}

python_test() {
	cp -a "${BUILD_DIR}"/{install,test} || die
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}

	local base_dir="${BUILD_DIR}/test/usr/lib/${EPYTHON}"
	local sandbox_dir="${base_dir}/site-packages/prefab_ui/sandbox"

	cp -a "${S}/skills" "${base_dir}" || die

	# Copy vendored Deno dependencies
	cp -a \
		"${WORKDIR}/deno."{lock,json} \
		"${WORKDIR}/node_modules" \
		"${WORKDIR}/vendor" "${sandbox_dir}/" || die
	# Copy vendored wheels
	cp -a "${WORKDIR}/pyodide_packages/"* "${sandbox_dir}/node_modules/pyodide/" || die

	# Show full error messages from Pyodide
	sed -i 's/err\[-1000:\]/err/' "${sandbox_dir}/_pyodide.py" || die

	local -x DENO_NO_REMOTE=1
	epytest
}
