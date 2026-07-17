# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Lightweight package to seamlessly call OpenAI, Azure, Cohere, Anthropic, etc."
HOMEPAGE="
	https://github.com/BerriAI/litellm
	https://pypi.org/project/litellm/
"
SRC_URI="
	https://github.com/BerriAI/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/fasys-guru/rehost/releases/download/v2026.07.14/${P}-openapi-spec.json.xz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64" # ~arm64: fastapi, tokenizers

CORE_DEPS="
	$(python_gen_cond_dep '
		>=dev-python/aiohttp-3.10.0[${PYTHON_USEDEP}]
		>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/fastuuid-0.14.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-0.28.0[${PYTHON_USEDEP}]
		>=dev-python/importlib-metadata-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
		>=dev-python/openai-2.20.0[${PYTHON_USEDEP}]
		>=dev-python/pydantic-2.10.0[${PYTHON_USEDEP}]
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/tiktoken-0.8.0[${PYTHON_USEDEP}]
	')
	>=sci-ml/tokenizers-0.21.0[${PYTHON_SINGLE_USEDEP}]
"

PROXY_AND_TEST_DEPS="
	$(python_gen_cond_dep '
		>=dev-python/apscheduler-3.11.2[${PYTHON_USEDEP}]
		>=dev-python/backoff-2.2.1[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.43.1[${PYTHON_USEDEP}]
		>=dev-python/expression-5.6.0[${PYTHON_USEDEP}]
		>=dev-python/fastapi-0.136.3[${PYTHON_USEDEP}]
		>=dev-python/fastapi-sso-0.19.0[${PYTHON_USEDEP}]
		>=dev-python/mcp-1.26.0[${PYTHON_USEDEP}]
		>=dev-python/orjson-3.11.6[${PYTHON_USEDEP}]
		>=dev-python/pyjwt-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
		>=dev-python/starlette-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
	')
"

# TODO
# azure-identity>=1.25.2
# azure-storage-blob>=12.28.0
# litellm-proxy-extras==0.4.74
# litellm-enterprise==0.1.44
# polars>=1.38.1
# pyroscope-io>=0.8.16
#
# staged (pending push to ::guru):
# >=dev-python/restrictedpython-8.1[${PYTHON_USEDEP}]
PROXY_DEPS="
	${PROXY_AND_TEST_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/cryptography-48.0.1[${PYTHON_USEDEP}]
		>=dev-python/pydantic-settings-2.14.1[${PYTHON_USEDEP}]
		>=dev-python/pynacl-1.6.2[${PYTHON_USEDEP}]
		>=dev-python/python-multipart-0.0.27[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
		>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
		>=dev-python/rq-2.7.0[${PYTHON_USEDEP}]
		>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
		>=dev-python/starlette-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.33.0[${PYTHON_USEDEP}]
		>=dev-python/uvloop-0.21.0[${PYTHON_USEDEP}]
		>=dev-python/websockets-15.0.1[${PYTHON_USEDEP}]
		>=www-servers/gunicorn-23.0.0[${PYTHON_USEDEP}]
	')
"

PROXY_RT_AND_TEST_DEPS="
	$(python_gen_cond_dep '
		>=dev-python/prometheus-client-0.20.0[${PYTHON_USEDEP}]
	')
"

# TODO
# anthropic[vertex]
# google-cloud-aiplatform>=1.133.0
# google-genai>=1.37.0
# langfuse>=2.59.7
# opentelemetry-instrumentation-fastapi==0.49b0
# ddtrace>=2.19.0,<3.0",
# sentry-sdk>=2.21.0
# mangum>=0.17.0,<1.0
# azure-ai-contentsafety>=1.0.0
# azure-storage-file-datalake>=12.20.0
# llm-sandbox>=0.3.39
# detect-secrets>=1.5.0
#
# omitted transitive dependencies:
# grpcio, opentelemetry-api
PROXY_RT_DEPS="
	${PROXY_RT_AND_TEST_DEPS}
	$(python_gen_cond_dep '
		dev-python/anthropic-0.84.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-exporter-otlp-proto-http-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-sdk-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/pypdf-6.12.0[${PYTHON_USEDEP}]
	')
"

# TODO
# pytest-postgresql==7.0.2
# opentelemetry-instrumentation-fastapi==0.49b0
# langfuse==2.59.7
# fastapi-offline==1.7.6
TEST_DEPS="
	$(python_gen_cond_dep '
		>=dev-python/fakeredis-2.34.1[${PYTHON_USEDEP}]
		>=dev-python/openapi-core-0.22.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-exporter-otlp-proto-http-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/opentelemetry-sdk-1.28.0[${PYTHON_USEDEP}]
		>=dev-python/parameterized-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/psycopg-3.3.3[native-extensions,${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.12.1[${PYTHON_USEDEP}]
		>=dev-python/responses-0.26.0[${PYTHON_USEDEP}]
	')
"

RDEPEND="
	${CORE_DEPS}
"

# google-auth is a transitive dependency we add to enable a few more tests
BDEPEND="
	test? (
		${PROXY_AND_TEST_DEPS}
		${PROXY_RT_AND_TEST_DEPS}
		${TEST_DEPS}
		$(python_gen_cond_dep '
			dev-python/google-auth[${PYTHON_USEDEP}]
		')
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,mock,recording} respx )
EPYTEST_RERUN=10
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# >=dev-python/redis-6
	sed '/from redis.commands.search.indexDefinition /s/indexDefinition/index_definition/' \
		-i litellm/caching/valkey_semantic_cache.py

	# patch online test
	local openapi_spec="${DISTDIR}/${P}-openapi-spec.json"
	sed -i \
		'/if __name__ == "__main__":/,/spec = response.json()/ {
			s|response = .*|import json; f = open("'"${openapi_spec}"'", "r")|
			s|spec = .*|spec = json.load(f); f.close()|
		}' tests/test_litellm/interactions/test_openapi_compliance.py || die
}

python_test() {
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}
	cp -a "${BUILD_DIR}"/{install,test} || die

	local EPYTEST_IGNORE=(
		# proxy
		tests/test_litellm/proxy/

		# a2a
		tests/test_litellm/a2a_protocol/
		tests/test_litellm/llms/langflow/test_langflow_a2a.py

		# azure-identity
		tests/test_litellm/caching/test_azure_blob_cache.py
		tests/test_litellm/llms/azure/test_azure_common_utils.py
		tests/test_litellm/secret_managers/test_get_azure_ad_token_provider.py

		# polars
		tests/test_litellm/integrations/cloudzero/test_cloudzero.py
		tests/test_litellm/integrations/cloudzero/test_cloudzero_database.py
		tests/test_litellm/integrations/cloudzero/test_cz_stream_api.py
		tests/test_litellm/integrations/cloudzero/test_dry_run_endpoint.py
		tests/test_litellm/integrations/cloudzero/test_transform.py
		tests/test_litellm/integrations/focus/test_csv_serializer.py
		tests/test_litellm/integrations/focus/test_focus_database.py
		tests/test_litellm/integrations/focus/test_focus_transformer.py
		tests/test_litellm/integrations/focus/test_transformer.py

		# network
		tests/test_litellm/llms/volcengine/test_volcengine_embedding.py

		# flaky due to module reloading
		tests/test_litellm/llms/custom_httpx/test_credential_leak_prevention.py
		tests/test_litellm/llms/custom_httpx/test_http_handler.py
		tests/test_litellm/llms/custom_httpx/test_llm_http_handler.py

		# Tests fail because inspect.getfullargspec(redis.Redis) isn't returning
		# the constructor args (Redis.__init__ is a wrapped function)
		# Fix: https://github.com/BerriAI/litellm/pull/30644
		tests/test_litellm/caching/test_redis_cache.py
		tests/test_litellm/caching/test_redis_connection_pool.py
		tests/test_litellm/test_redis.py
	)
	local EPYTEST_DESELECT=(
		# azure-identity
		tests/test_litellm/secret_managers/test_secret_managers_main.py::test_oidc_azure_ad_token_succes

		# google-cloud-aiplatform
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_dispatch_vertex_ai_legacy_function_call
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_dispatch_vertex_ai_legacy_text_and_finish_reason
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_dispatch_vertex_ai_legacy_without_candidates_stringifies_chunk
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_gemini_legacy_vertex_stop_finish_reason_normalised
		tests/test_litellm/litellm_core_utils/test_streaming_handler.py::test_gemini_legacy_vertex_tool_calls_finish_reason_with_stop_enum
		tests/test_litellm/llms/gemini/test_gemini_common_utils.py::TestGoogleAIStudioTokenCounter::test_clean_contents_for_gemini_api_preserves_other_fields
		tests/test_litellm/llms/gemini/test_gemini_common_utils.py::TestGoogleAIStudioTokenCounter::test_clean_contents_for_gemini_api_removes_id_field
		tests/test_litellm/llms/vertex_ai/vertex_ai_partner_models/anthropic/test_vertex_ai_partner_models_anthropic_messages_config.py::test_vertex_claude_completion_does_not_mutate_shared_extra_headers
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_basic_request
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_error_handling
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_fake_streaming
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_filters_context_management
		tests/test_litellm/llms/vertex_ai/vertex_gemma_models/test_vertex_gemma_transformation.py::TestVertexGemmaCompletion::test_acompletion_filters_stream_and_stream_options

		# polars
		tests/test_litellm/integrations/focus/test_mavvrik_destination.py::test_catchup_capped_at_max_catchup_days
		tests/test_litellm/integrations/focus/test_mavvrik_destination.py::test_export_window_passes_max_rows_as_limit
		tests/test_litellm/integrations/focus/test_mavvrik_destination.py::test_run_scheduled_export_catches_up_missed_dates
		tests/test_litellm/integrations/focus/test_mavvrik_destination.py::test_run_scheduled_export_no_catchup_when_marker_is_current
		tests/test_litellm/integrations/focus/test_mavvrik_destination.py::test_run_scheduled_export_skips_catchup_when_marker_is_unparseable

		# langfuse
		tests/test_litellm/enterprise/enterprise_callbacks/test_callback_controls.py::TestEnterpriseCallbackControls::test_callback_disabled_langfuse_customlogger

		# git
		tests/test_litellm/test_budget_ratchet_check.py::test_ref_is_commit_distinguishes_real_from_bogus
		tests/test_litellm/test_budget_ratchet_check.py::test_load_base_reads_a_present_file_and_none_for_an_absent_one

		# flaky (async ordering issues)
		tests/test_litellm/caching/test_s3_cache.py::test_s3_cache_async_set_cache_pipeline
		tests/test_litellm/caching/test_s3_cache.py::test_s3_cache_concurrent_async_operations

		# network
		tests/test_litellm/llms/bedrock/chat/agentcore/test_agentcore_transformation.py::TestAgentCoreStreamingJsonFallback::test_async_streaming_malformed_json_raises_error
		tests/test_litellm/llms/bedrock/chat/agentcore/test_agentcore_transformation.py::TestAgentCoreStreamingJsonFallback::test_async_streaming_with_json_response
	)

	# Covered by the BerriAI Enterprise license
	# Our "non-production-use" is implicitly allowed
	# https://github.com/BerriAI/litellm/blob/v1.89.3/enterprise/LICENSE.md
	pushd enterprise >/dev/null || die
	distutils_pep517_install "${BUILD_DIR}"/test
	popd >/dev/null || die

	epytest --import-mode=importlib tests/test_litellm
}
