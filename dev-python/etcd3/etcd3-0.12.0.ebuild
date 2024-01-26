# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	tests/test_etcd3.py::TestClient::test_compact
	tests/test_etcd3.py::TestClient::test_user_pwd_auth
	tests/test_etcd3.py::TestEtcd3
	tests/test_etcd3.py::TestAlarms
)
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Python client for the etcd API v3"
HOMEPAGE="
	https://pypi.org/project/etcd3/
	https://github.com/kragniz/python-etcd3
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/etcd
	>=dev-python/grpcio-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-5.0.2[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.6.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		dev-python/grpcio-tools[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-util/pifpaf[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
