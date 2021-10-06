# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_alarm_id_or_name_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_composite_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_event_alarm_create_show_query
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_event_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_help
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_set_get_alarm_state
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_threshold_alarm_create_show_query
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_threshold_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientTest::test_update_type_event_composite
	aodhclient/tests/functional/test_alarm.py::AodhClientGnocchiRulesTest::test_gnocchi_aggr_by_metrics_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientGnocchiRulesTest::test_gnocchi_aggr_by_resources_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientGnocchiRulesTest::test_gnocchi_resources_threshold_scenario
	aodhclient/tests/functional/test_alarm.py::AodhClientGnocchiRulesTest::test_update_gnaggrresthr_gnaggrmetricthr
	aodhclient/tests/functional/test_alarm.py::AodhClientGnocchiRulesTest::test_update_gnresthr_gnaggrresthr
	aodhclient/tests/functional/test_alarm_history.py::AlarmHistoryTest::test_alarm_history_scenario
	aodhclient/tests/functional/test_alarm_history.py::AlarmHistoryTest::test_help
	aodhclient/tests/functional/test_capabilities.py::CapabilitiesClientTest::test_capabilities_scenario
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Aodh API"
HOMEPAGE="
	https://github.com/openstack/python-aodhclient
	https://opendev.org/openstack/python-aodhclient
	https://pypi.org/project/aodhclient
	https://launchpad.net/python-aodhclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.4[${PYTHON_USEDEP}]
	>=dev-python/cliff-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-1.0.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/reno-1.6.2[${PYTHON_USEDEP}]
		>=dev-python/tempest-10[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-0.23[${PYTHON_USEDEP}]
		dev-python/gnocchi[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
