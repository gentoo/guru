# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="A python library for decision tree visualization and model interpretation"
HOMEPAGE="
	https://pypi.org/project/dtreeviz/
"
SRC_URI="https://github.com/parrt/dtreeviz/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# IUSE="test xgboost pyspark lightgbm"
IUSE="test"

RDEPEND="
	>=dev-python/graphviz-0.9
	dev-python/pandas
	dev-python/numpy
	dev-python/scikit-learn
	dev-python/matplotlib
	dev-python/colour
"
# xgboost: available at the science overlay: https://github.com/gentoo/sci - Tested
# pyspark: available at the spark overlay: https://github.com/6-6-6/spark-overlay - Not tested
# lightgbm: available at the pypi-sci overlay: https://github.com/jiegec/gentoo-pypi-sci - Not tested

DEPEND="test? ( dev-python/pytest )"

TEST_DIR="testing/testlib/models"

python_prepare_all() {
	# FIXME
	#if ! use xgboost; then
		rm $TEST_DIR/test_decision_trees_xgb_classifier.py || die
		rm $TEST_DIR/test_decision_tree_xgb_regressor.py || die
	#fi

	# if ! use pyspark; then
	rm $TEST_DIR/test_decision_tree_spark_classifier.py || die
	# fi

	# if ! use lightgbm; then
	rm $TEST_DIR/test_decision_tree_lightgbm_classifier.py || die
	# fi

	#TODO: tensorflow_decision_forests ebuild
	rm $TEST_DIR/test_decision_tree_tensorflow_classifier.py || die

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
