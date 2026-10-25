# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_USE_PEP517=uv-build
DISTUTILS_SINGLE_IMPL=yes

inherit distutils-r1 systemd

DESCRIPTION="Open source video conferencing app powered by LiveKit"
HOMEPAGE="
	https://visio.numerique.gouv.fr/
	https://github.com/suitenumerique/meet/
"
# Deps tarballs generated with app-portage/nodebuild::2xsaiko.
SRC_URI="
	https://github.com/suitenumerique/meet/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://dblsaiko.net/pub/dist/${P}-frontend-deps.tar.xz
	https://dblsaiko.net/pub/dist/${P}-mail-deps.tar.xz
"

PATCHES=( "${FILESDIR}"/unrestrict-uv-version.patch )

S="${WORKDIR}/meet-${PV}"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/django-7
	>=www-servers/gunicorn-26.2.0

	$(python_gen_cond_dep '
		>=dev-python/boto3-1.43.56[${PYTHON_USEDEP}]
		>=dev-python/brotlicffi-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/dj-database-url-3.1.2[${PYTHON_USEDEP}]
		>=dev-python/django-configurations-2.5.1[${PYTHON_USEDEP}]
		>=dev-python/django-cors-headers-4.9.0[${PYTHON_USEDEP}]
		>=dev-python/redis-5.2.1[${PYTHON_USEDEP}]
		>=dev-python/django-redis-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/django-timezone-field-5.1[${PYTHON_USEDEP}]
		>=dev-python/django-5.2.16[${PYTHON_USEDEP}]
		>=dev-python/djangorestframework-3.17.1[${PYTHON_USEDEP}]
		>=dev-python/easy-thumbnails-2.10.1[${PYTHON_USEDEP}]
		>=www-servers/gunicorn-26.2.0[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-4.26.0[${PYTHON_USEDEP}]
		>=dev-python/markdown-3.10.2[${PYTHON_USEDEP}]
		>=dev-python/posthog-7.29.0[${PYTHON_USEDEP}]
		>=dev-python/psycopg-3.3.4[${PYTHON_USEDEP}]
		>=dev-python/pydantic-2.13.4[${PYTHON_USEDEP}]
		>=dev-python/pyjwt-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/python-frontmatter-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/python-magic-0.4.27[${PYTHON_USEDEP}]
		>=dev-python/requests-2.34.2[${PYTHON_USEDEP}]
		>=dev-python/sentry-sdk-2.66.1[${PYTHON_USEDEP}]
		>=dev-python/whitenoise-6.12.0[${PYTHON_USEDEP}]
		>=dev-python/aiohttp-3.14.3[${PYTHON_USEDEP}]
		>=dev-python/urllib3-2.7.0[${PYTHON_USEDEP}]
		>=dev-python/phonenumbers-9.0.24[${PYTHON_USEDEP}]
		>=dev-python/cryptography-50.0.0[${PYTHON_USEDEP}]

		>=dev-python/brevo-python-1.2.0:1[${PYTHON_USEDEP}]
		>=dev-python/celery-5.6.3[${PYTHON_USEDEP}]
			dev-python/redis[${PYTHON_USEDEP}]
		>=dev-python/django-countries-9.0.0[${PYTHON_USEDEP}]
		>=dev-python/django-filter-26.1[${PYTHON_USEDEP}]
		>=dev-python/django-lasuite-0.0.27[${PYTHON_USEDEP}]
			>=dev-python/celery-5.0[${PYTHON_USEDEP}]
			>=dev-python/django-configurations-2.5.1[${PYTHON_USEDEP}]
		>=dev-python/django-parler-2.4[${PYTHON_USEDEP}]
		>=dev-python/django-storages-1.14.6[${PYTHON_USEDEP}]
			>=dev-python/boto3-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/django-pydantic-field-0.5.4[${PYTHON_USEDEP}]
		>=dev-python/drf-spectacular-0.30.0[${PYTHON_USEDEP}]
		>=dev-python/dockerflow-2026.3.4[${PYTHON_USEDEP}]
		>=dev-python/factory-boy-3.3.3[${PYTHON_USEDEP}]
		>=dev-python/nested-multipart-parser-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/mozilla-django-oidc-5.0.2[${PYTHON_USEDEP}]
		>=dev-python/livekit-api-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/django-extensions-4.2_pre20261031[${PYTHON_USEDEP}]
		>=dev-python/drf-spectacular-sidecar-2026.9.1[${PYTHON_USEDEP}]
		>=dev-python/freezegun-1.5.5[${PYTHON_USEDEP}]
		>=dev-python/joserfc-1.7.5[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	net-libs/nodejs[npm]
	test? (
		${RDEPEND}
		dev-db/redis
		dev-db/postgresql
	)
"

EPYTEST_PLUGINS=( pytest-{django,cov} )
EPYTEST_DESELECT=(
	# Needs an s3 server
	core/tests/commands/test_clean_pending_files.py::test_clean_pending_files_recent_pending_not_deleted
	core/tests/commands/test_clean_pending_files.py::test_clean_pending_files_old_pending_deleted
	core/tests/commands/test_clean_pending_files.py::test_clean_pending_files_custom_hours
	core/tests/files/test_api_files_media_auth.py::test_api_files_media_get_own
	core/tests/files/test_api_files_media_auth.py::test_api_files_media_auth_own_file_deleted
	core/tests/files/test_api_files_media_auth.py::test_api_files_media_auth_custom_original_url_header
	core/tests/files/test_api_files_upload_ended.py::test_api_file_upload_ended_success
	core/tests/files/test_api_files_upload_ended.py::test_api_file_upload_ended_mimetype_not_allowed_not_checking_mimetype
	core/tests/files/test_api_files_upload_ended.py::test_api_upload_ended_mismatch_mimetype_with_object_storage
	core/tests/recording/test_api_recordings_media_auth.py::test_api_recordings_media_auth_success_owner
	core/tests/recording/test_api_recordings_media_auth.py::test_api_recordings_media_auth_success_administrator
	core/tests/commands/test_purge_deleted_files.py::test_purge_deleted_files_success
	core/tests/files/test_api_files_upload_ended.py::test_api_file_upload_ended_mimetype_not_allowed
	core/tests/files/test_api_files_upload_ended.py::test_api_upload_ended_file_size_exceeded
	core/tests/files/test_api_files_upload_ended.py::test_api_file_upload_ended_concurrent_calls_are_serialized

	# Works but expects French text instead of English
	core/tests/recording/event/test_notification.py::test_notify_user_by_email_success

	# Other
	core/tests/recording/event/test_notification.py::test_notify_summary_service_post_args_with_metadata
	core/tests/test_external_api_rooms.py::test_api_rooms_list_with_invalid_rs_token
	core/tests/test_external_api_rooms.py::test_api_rooms_retrieve_with_invalid_rs_token
	core/tests/test_external_api_rooms.py::test_api_rooms_create_with_invalid_rs_token
)
distutils_enable_tests pytest

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"/src/frontend || die
	unpack "${P}-frontend-deps.tar.xz"
	cd "${S}"/src/mail || die
	unpack "${P}-mail-deps.tar.xz"
}

src_compile() {
	cd "${S}"/src/frontend || die
	npm --offline --verbose run build || die "npm build failed"
	cd "${S}"/src/mail || die
	npm --offline --verbose run build || die "npm build failed"
	cd "${S}"/src/backend || die
	distutils-r1_src_compile
	export DJANGO_DATA_DIR="${WORKDIR}"/data
	"${EPYTHON}" manage.py collectstatic --noinput --clear || die
}

python_test() {
	cd "${S}"/src/backend || die

	# Tests expect a running redis server, so let's provide it
	exec 3< <(redis-server /dev/null || die 'failed to run redis server')
	local redis_pid=$!

	# Wait until it's ready
	while IFS= read -r line <&3 || die "failed to start redis server"; do
		echo "$line"
		[[ "$line" =~ "Ready to accept connections" ]] && break
	done
	cat <&3 &

	# Same for postgres
	initdb -D "${WORKDIR}/pgdata" --username=dinum --pwfile=<(echo 'pass') --auth=trust --locale=C.UTF-8 || die
	printf "unix_socket_directories = '%s'\n" "${WORKDIR}" >> "${WORKDIR}"/pgdata/postgresql.conf || die
	pg_ctl -D "${WORKDIR}/pgdata" start || die

	local -x DJANGO_SETTINGS_MODULE=meet.settings
	local -x DJANGO_CONFIGURATION=Test
	local -x DJANGO_SECRET_KEY=DummyKey
	local -x REDIS_URL="redis://localhost:6379/1"
	local -x CELERY_BROKER_URL="redis://localhost:6379/0"

	local -x AWS_S3_ENDPOINT_URL="http://localhost:9000"
	local -x AWS_S3_ACCESS_KEY_ID=meet
	local -x AWS_S3_SECRET_ACCESS_KEY=meet-secret-access-key
	local -x AWS_S3_REGION_NAME=us-east-1
	local -x OIDC_OP_JWKS_ENDPOINT="http://localhost:8083/realms/meet/protocol/openid-connect/certs"
	local -x OIDC_OP_TOKEN_ENDPOINT="http://localhost:8083/realms/meet/protocol/openid-connect/token"
	local -x OIDC_OP_USER_ENDPOINT="http://localhost:8083/realms/meet/protocol/openid-connect/userinfo"
	local -x OIDC_OP_INTROSPECTION_ENDPOINT="http://localhost:8083/realms/meet/protocol/openid-connect/token/introspect"
	nonfatal epytest
	local epytest_result=$?

	kill -INT $redis_pid
	wait $redis_pid

	pg_ctl -D "${WORKDIR}/pgdata" stop || die

	(( epytest_result == 0 )) || die "pytest failed with ${EPYTHON}"
}

src_install() {
	dodir /usr/share/"${PN}"
	cp -r src/frontend/dist "${ED}"/usr/share/"${PN}"/www || die
	cp -r "${WORKDIR}"/data/static "${ED}"/usr/share/"${PN}"/www/static || die

	chmod +x src/backend/manage.py || die
	python_fix_shebang src/backend/manage.py

	dodir /usr/libexec
	cp -r src/backend "${ED}"/usr/libexec/"${PN}" || die
	python_optimize "${ED}"/usr/libexec/"${PN}"

	dobin "${FILESDIR}/${PN}-manage"

	systemd_dounit "${FILESDIR}"/lasuite-meet.service
	insinto /etc/default
	insopts -m0600
	newins "${FILESDIR}"/lasuite-meet.conf lasuite-meet

	exeinto /usr/libexec
	doexe "${FILESDIR}"/lasuite-meet-launch

	dodoc "${FILESDIR}"/Caddyfile
}
