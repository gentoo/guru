# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=(
	os_win/tests/unit/utils/compute/test_livemigrationutils.py::LiveMigrationUtilsTestCase::test_check_live_migration_config
	os_win/tests/unit/utils/compute/test_livemigrationutils.py::LiveMigrationUtilsTestCase::test_create_planned_vm
	os_win/tests/unit/utils/compute/test_livemigrationutils.py::LiveMigrationUtilsTestCase::test_get_vhd_setting_data
	os_win/tests/unit/utils/compute/test_livemigrationutils.py::LiveMigrationUtilsTestCase::test_live_migrate_single_planned_vm
	os_win/tests/unit/utils/compute/test_livemigrationutils.py::LiveMigrationUtilsTestCase::test_update_planned_vm_disk_resources
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_check_admin_permissions
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_create_vm_1_True
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_create_vm_2_False
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_detach_vm_disk
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_disable_remotefx_video_adapter
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_disable_remotefx_video_adapter_not_found
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_enable_remotefx_video_adapter
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_get_mounted_disk_resource_from_path_1_None
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_get_mounted_disk_resource_from_path_2
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_get_vm_disks
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_get_vm_serial_ports
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_remove_vm_snapshot
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_set_vm_vcpus
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_set_vm_vcpus_per_vnuma_node
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_take_vm_snapshot_1_None
	os_win/tests/unit/utils/compute/test_vmutils.py::VMUtilsTestCase::test_take_vm_snapshot_2
	os_win/tests/unit/utils/network/test_networkutils.py::NetworkUtilsTestCase::test_create_default_setting_data
	os_win/tests/unit/utils/network/test_networkutils.py::NetworkUtilsTestCase::test_is_port_vm_started_false
	os_win/tests/unit/utils/network/test_networkutils.py::NetworkUtilsTestCase::test_is_port_vm_started_true
)
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Windows / Hyper-V library for OpenStack projects."
HOMEPAGE="
	https://github.com/openstack/os-win
	https://opendev.org/openstack/os-win
	https://launchpad.net/os-win
	https://pypi.org/project/os-win/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.29.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.2.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.8.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
