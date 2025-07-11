# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Python-based library for exporting HID UPS data as metrics for Prometheus."
HOMEPAGE="https://github.com/desultory/hid_ups_exporter"
SRC_URI="https://github.com/desultory/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/zenlib-2.1.2[${PYTHON_USEDEP}]
	>=dev-python/hid_ups-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/prometheus_exporter-1.0.0[${PYTHON_USEDEP}]
"

src_install() {
	# Install the package
	distutils-r1_src_install

	# Copy hid_ups_exporter.include to /etc/init.d
	newinitd hid_ups_exporter.include hid_ups_exporter
	# Create /var/log/hid_ups_exporter
	keepdir /var/log/hid_ups_exporter
}
