# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Lib and CLI for archive.org - for search, uploading, downloading, rename etc"
HOMEPAGE="https://github.com/jjjake/internetarchive"

SRC_URI="https://github.com/jjjake/internetarchive/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jsonpatch[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/schema[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

# Because they want internet
EPYTEST_DESELECT=(
	tests/cli/test_ia.py::test_ia
	tests/cli/test_ia_download.py::test_checksum
	tests/cli/test_ia_download.py::test_checksum_archive
	tests/cli/test_ia_download.py::test_clobber
	tests/cli/test_ia_download.py::test_destdir
	tests/cli/test_ia_download.py::test_dry_run
	tests/cli/test_ia_download.py::test_exclude
	tests/cli/test_ia_download.py::test_format
	tests/cli/test_ia_download.py::test_glob
	tests/cli/test_ia_download.py::test_https
	tests/cli/test_ia_download.py::test_no_args
	tests/cli/test_ia_download.py::test_no_directories
	tests/cli/test_ia_download.py::test_on_the_fly_format
	tests/cli/test_ia_upload.py::test_ia_upload_invalid_identifier
	tests/test_api.py::test_get_item_with_kwargs
	tests/test_api.py::test_upload_validate_identifier
	tests/test_item.py::test_download_ignore_errors
	tests/test_item.py::test_upload
	tests/test_item.py::test_upload_automatic_size_hint
	tests/test_item.py::test_upload_metadata
	tests/test_item.py::test_upload_queue_derive
	tests/test_item.py::test_upload_validate_identifier
	tests/test_session.py::test_cookies
	tests/test_session.py::test_s3_is_overloaded
)

distutils_enable_tests pytest
