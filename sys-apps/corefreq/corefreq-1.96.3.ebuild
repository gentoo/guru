# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod systemd

DESCRIPTION="CPU monitoring software designed for the 64-bits Processors, like top"
HOMEPAGE="https://www.cyring.fr/"
SRC_URI="https://github.com/cyring/$PN/archive/$PV.tar.gz -> $P.tar.gz"
S="${WORKDIR}/CoreFreq-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="doc systemd"

DEPEND="dev-build/make
	kernel_linux? ( virtual/linux-sources )"

BDEPEND="sys-devel/gcc
	dev-build/make
	dev-vcs/git"

RDEPEND="sys-libs/glibc"

CONFIG_CHECK="SMP X86_MSR ~HOTPLUG_CPU ~CPU_IDLE ~CPU_FREQ ~PM_SLEEP ~DMI ~XEN ~AMD_NB ~HAVE_PERF_EVENTS ~SCHED_MUQSS ~SCHED_BMQ ~SCHED_PDS"

BUILD_TARGETS="clean all"

MODULE_NAMES="corefreqk(misc:${S})"
MODULESD_COREFREQK_ENABLED="yes"

pkg_setup() {
	get_version
	require_configured_kernel
	BUILD_PARAMS="KERNELDIR=/lib/modules/${KV_FULL}/build"
	linux-mod_pkg_setup
}

QA_FLAGS_IGNORED="usr/bin/.*"

src_install() {
	linux-mod_src_install
	dobin corefreqd corefreq-cli
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	doinitd "${FILESDIR}/${PN}"
	use systemd && systemd_dounit ${PN}d.service
	use doc && dodoc README.md
}

pkg_postinst() {
	einfo "To be able to use corefreq, you need to load kernel module:"
	einfo "modprobe corefreqk"
	einfo "After that - start daemon with corefreqd"
	einfo "or by `rc-service corefreq start`"
	einfo "And only after that you can start corefreq-cli"
}
