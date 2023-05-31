# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="CPU monitoring software designed for the 64-bits Processors"
HOMEPAGE="https://github.com/cyring/CoreFreq"
SRC_URI="https://github.com/cyring/CoreFreq/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

BDEPEND="sys-devel/gcc
		sys-devel/make
		dev-vcs/git"
RDEPEND="sys-libs/glibc"

CONFIG_CHECK="SMP X86_MSR ~HOTPLUG_CPU ~CPU_IDLE ~CPU_FREQ ~PM_SLEEP ~DMI ~XEN ~AMD_NB ~HAVE_PERF_EVENTS ~SCHED_MUQSS ~SCHED_BMQ ~SCHED_PDS"

MODULE_NAMES="corefreqk()"
BUILD_TARGETS="clean all"

pkg_setup() {
	if kernel_is -lt 3 3 ; then
		die "kernels < 3.3 are not supported"
	fi

	elog "Checking for kernel configurations..."
	elog "Enable optional configurations only as you see fit."
	elog "Not all optional configurations will be suitable for your system."
	elog "Build will fail for required configs."
	elog "The other configs are all optional configs."

	linux-mod_pkg_setup
}

src_unpack() {
	default
	mv CoreFreq-${PV} ${P}
}

src_install() {
	linux-mod_src_install
	emake -j1 PREFIX="${D}/usr" install
	newinitd "${FILESDIR}/corefreqd corefreqd"
}
