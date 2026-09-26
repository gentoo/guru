# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature

DESCRIPTION="Collection of custom storage backends for Django"
HOMEPAGE="
	https://github.com/jschneier/django-storages
	https://pypi.org/project/django-storages/"
SRC_URI="https://github.com/jschneier/django-storages/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

PATCHES=( "${FILESDIR}/1.14.6-fix-moto-import.patch" )

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-4.2[${PYTHON_USEDEP}]"

BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/isodate-0.7.2[${PYTHON_USEDEP}]
		>=dev-python/azure-core-1.13[${PYTHON_USEDEP}]
		>=dev-python/azure-storage-blob-12[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/moto-5[${PYTHON_USEDEP}]
		>=dev-python/dropbox-7.2.1[${PYTHON_USEDEP}]
		>=dev-python/paramiko-1.15[${PYTHON_USEDEP}] )"

EPYTEST_IGNORE=( tests/test_gcloud.py )
distutils_enable_tests pytest

python_test() {
	local -x DJANGO_SETTINGS_MODULE=tests.settings
	epytest
}

pkg_postinst() {
	optfeature "azure" ">=dev-python/azure-core-1.13 >=dev-python/azure-storage-blob-12"
	optfeature "boto3" ">=dev-python/boto3-1.4.4"
	optfeature "dropbox" ">=dev-python/dropbox-7.2.1"
	# not packaged
	#optfeature "google" ">=dev-python/google-cloud-storage-1.36.1"
	optfeature "libcloud" "dev-python/apache-libcloud"
	optfeature "s3" ">=dev-python/boto3-1.4.4"
	optfeature "sftp" ">=dev-python/paramiko-1.15"
}
