# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

# testsuite needs it own source
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_USE_SETUPTOOLS=rdepend
MYPV="${PV/_beta/b}"
PYTHON_COMPAT=( python3_8 )

inherit bash-completion-r1 distutils-r1 eutils optfeature

DESCRIPTION="Asynchronous task queue/job queue based on distributed message passing"
HOMEPAGE="
	http://celeryproject.org
	https://pypi.org/project/celery
	https://github.com/celery/celery
"
SRC_URI="https://github.com/celery/celery/archive/v${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples" # There are a number of other optional 'extras'

#RESTRICT="!test? ( test )"
RESTRICT="test" # 'celery' not found in `markers` configuration option

RDEPEND="
	>=dev-python/billiard-3.6.4.0[${PYTHON_USEDEP}]
	<dev-python/billiard-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-7[${PYTHON_USEDEP}]
	<dev-python/click-8[${PYTHON_USEDEP}]
	>=dev-python/click-didyoumean-0.0.3[${PYTHON_USEDEP}]
	>=dev-python/click-plugins-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/click-repl-0.1.6[${PYTHON_USEDEP}]
	<dev-python/kombu-6.0[${PYTHON_USEDEP}]
	>=dev-python/kombu-5[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/vine-5[${PYTHON_USEDEP}]
	<dev-python/vine-6[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/boto3-1.9.178[${PYTHON_USEDEP}]
		>=dev-python/case-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/moto-1.3.7[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.2[${PYTHON_USEDEP}]
		dev-python/pytest-celery[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
		>=dev-python/pyzmq-13.1.0[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		>=dev-python/sphinx_celery-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-click-2.5.0[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd-r2" celery
	newconfd "${FILESDIR}/celery.confd-r2" celery

	if use examples; then
		docinto examples
		dodoc -r examples/.
		docompress -x "/usr/share/doc/${PF}/examples"
	fi

	newbashcomp extra/bash-completion/celery.bash "${PN}"

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "zookeeper support" dev-python/kazoo
	optfeature "msgpack support" dev-python/msgpack
	#optfeature "rabbitmq support" dev-python/librabbitmq
	#optfeature "slmq support" dev-python/softlayer_messaging
	optfeature "eventlet support" dev-python/eventlet
	#optfeature "couchbase support" dev-python/couchbase
	optfeature "redis support" dev-db/redis dev-python/redis-py
	optfeature "gevent support" dev-python/gevent
	optfeature "auth support" dev-python/pyopenssl
	optfeature "pyro support" dev-python/pyro:4
	optfeature "yaml support" dev-python/pyyaml
	optfeature "memcache support" dev-python/pylibmc
	optfeature "mongodb support" dev-python/pymongo
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "sqs support" dev-python/boto
	#optfeature "cassandra support" dev-python/cassandra-driver
}
