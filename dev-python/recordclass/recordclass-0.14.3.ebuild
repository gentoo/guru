# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Mutable variants of tupe and collections.namedtuple"
HOMEPAGE="https://pypi.org/project/recordclass/"
if [[ ${PV} == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/intellimath/recordclass.git"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

# lib/recordclass/mutabletuple.c:727: PyObject *mutabletuple_copy(PyMutableTupleObject *): Assertion `PyTuple_Check(ob)' failed.
RESTRICT="test"

DEPEND="dev-python/cython"
RDEPEND="${DEPEND}"

python_test() {
	[[ -n ${EPYTHON} ]] || die "EPYTHON unset, invalid call context"
	${EPYTHON} ./test_all.py
}
