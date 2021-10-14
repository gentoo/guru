# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	senlinclient/tests/functional/test_actions.py::ActionTest::test_action_list
	senlinclient/tests/functional/test_cluster_policy.py::ClusterPolicyTest::test_cluster_policy_attach_and_detach
	senlinclient/tests/functional/test_cluster_policy.py::ClusterPolicyTest::test_cluster_policy_list
	senlinclient/tests/functional/test_cluster_policy.py::ClusterPolicyTest::test_cluster_policy_update
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_check
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_create
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_expand_and_shrink
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_full_id
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_limit
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_list
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_list_filters
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_list_sort
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_members_add_and_del
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_members_list
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_members_replace
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_recover
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_resize
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_show
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_update
	senlinclient/tests/functional/test_clusters.py::ClusterTest::test_cluster_update_profile_only
	senlinclient/tests/functional/test_events.py::EventTest::test_event_list
	senlinclient/tests/functional/test_help.py::HelpTest::test_help_cmd
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_check
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_create
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_detail
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_list
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_recover
	senlinclient/tests/functional/test_nodes.py::NodeTest::test_node_update
	senlinclient/tests/functional/test_policies.py::PolicyTest::test_policy_create
	senlinclient/tests/functional/test_policies.py::PolicyTest::test_policy_list
	senlinclient/tests/functional/test_policies.py::PolicyTest::test_policy_update
	senlinclient/tests/functional/test_policy_types.py::PolicyTypeTest::test_policy_type_list
	senlinclient/tests/functional/test_policy_types.py::PolicyTypeTest::test_policy_type_show
	senlinclient/tests/functional/test_profile_types.py::ProfileTypeTest::test_profile_list_debug
	senlinclient/tests/functional/test_profile_types.py::ProfileTypeTest::test_profile_type_list
	senlinclient/tests/functional/test_profile_types.py::ProfileTypeTest::test_profile_type_show
	senlinclient/tests/functional/test_profile_types.py::ProfileTypeTest::test_profile_type_show_json
	senlinclient/tests/functional/test_profiles.py::ProfileTest::test_pofile_create
	senlinclient/tests/functional/test_profiles.py::ProfileTest::test_profile_list
	senlinclient/tests/functional/test_profiles.py::ProfileTest::test_profile_update
	senlinclient/tests/functional/test_readonly_senlin.py::FakeTest::test_fake_action
	senlinclient/tests/functional/test_receivers.py::ReceiverTest::test_receiver_create
	senlinclient/tests/functional/test_receivers.py::ReceiverTest::test_receiver_list
	senlinclient/tests/functional/test_receivers.py::ReceiverTest::test_receiver_update
	senlinclient/tests/functional/test_version.py::VersionTest::test_openstack_version
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Senlin API"
HOMEPAGE="
	https://github.com/openstack/python-senlinclient
	https://opendev.org/openstack/python-senlinclient
	https://launchpad.net/python-senlinclient
	https://pypi.org/project/python-senlinclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.11.0[${PYTHON_USEDEP}]
	>=dev-python/openstacksdk-0.24.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/python-heatclient-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-openstackclient-3.12.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/tempest-17.1.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
