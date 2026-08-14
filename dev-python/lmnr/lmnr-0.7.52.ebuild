# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="lmnr-python"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Python SDK for Laminar"
HOMEPAGE="
	https://github.com/lmnr-ai/lmnr-python
	https://pypi.org/project/lmnr/
"
SRC_URI="
	https://github.com/lmnr-ai/${MY_PN}/archive/refs/tags/${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/grpcio-1[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.24.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.39.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.39.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-exporter-otlp-proto-http-1.39.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-instrumentation-0.54_beta0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-instrumentation-threading-0.54_beta0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-sdk-1.39.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-semantic-conventions-0.60_beta1[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-semantic-conventions-ai-0.4.13[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-22.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.3[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.0[${PYTHON_USEDEP}]
"
# FIXME keyword litellm and dependencies for arm64
BDEPEND="
	test? (
		>=dev-python/anthropic-0.95.0[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.28.57[${PYTHON_USEDEP}]
		!arm64? (
			$(python_gen_any_dep '
				>=dev-python/litellm-1.85.2[${PYTHON_SINGLE_USEDEP}]
			')
		)
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,recording,sugar} )
distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		# missing optional deps
		tests/test_google_genai.py
		tests/test_instrumentations/test_claude_agent/
		tests/test_langchain.py
		tests/test_instrumentations/test_groq/
		tests/test_instrumentations/test_openai_agents/
	)
	local EPYTEST_DESELECT=(
		# google-genai
		tests/test_utils.py::test_merge_text_parts_empty_list
		tests/test_utils.py::test_merge_text_parts_consecutive_strings
		tests/test_utils.py::test_merge_text_parts_consecutive_part_objects
		tests/test_utils.py::test_merge_text_parts_consecutive_part_dicts
		tests/test_utils.py::test_merge_text_parts_mixed_types
		tests/test_utils.py::test_merge_text_parts_with_non_text_part
		tests/test_utils.py::test_merge_text_parts_with_function_call
		tests/test_utils.py::test_merge_text_parts_multiple_non_text_parts
		tests/test_utils.py::test_merge_text_parts_only_non_text_parts
		tests/test_utils.py::test_merge_text_parts_single_text_part
		tests/test_utils.py::test_merge_text_parts_with_file_object
		tests/test_utils.py::test_merge_text_parts_trailing_text_only
		tests/test_utils.py::test_merge_text_parts_leading_non_text

		# langchain-openai
		tests/test_observe_concurrency.py::test_observe_threadpool_parallel_spans_with_langchain
		tests/test_tracing.py::test_use_span_with_auto_instrumentation_langchain
		tests/test_tracing_concurrency.py::test_threadpool_parallel_spans_with_langchain

		# network
		tests/test_instrumentations/test_openai/traces/test_chat.py::test_chat_exception
		tests/test_instrumentations/test_openai/traces/test_chat.py::test_chat_async_exception
		tests/test_instrumentations/test_openai/traces/test_chat_parse.py::test_parsed_completion_exception
		tests/test_instrumentations/test_openai/traces/test_chat_parse.py::test_async_parsed_completion_exception
		tests/test_instrumentations/test_openai/traces/test_completions.py::test_completion_streaming
		tests/test_instrumentations/test_openai/traces/test_completions.py::test_completion_exception
		tests/test_instrumentations/test_openai/traces/test_completions.py::test_async_completion_exception
		tests/test_instrumentations/test_openai/traces/test_embeddings.py::test_embeddings_exception
		tests/test_instrumentations/test_openai/traces/test_embeddings.py::test_async_embeddings_exception
	)

	if ! has_version "dev-python/litellm[${PYTHON_SINGLE_USEDEP}]"; then
		EPYTEST_IGNORE+=(
			tests/test_litellm.py
		)
	fi

	epytest
}
