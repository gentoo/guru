# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd

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

CONFIG_CHECK="SMP X86_MSR ~HOTPLUG_CPU ~CPU_IDLE ~CPU_FREQ ~PM_SLEEP ~DMI ~HAVE_NMI ~XEN ~AMD_NB ~SCHED_MUQSS ~SCHED_BMQ ~SCHED_PDS ~SCHED_ALT ~SCHED_BORE ~CACHY ~ACPI ~ACPI_CPPC_LIB"

QA_PREBUILT="
	/usr/bin/${PN}d
	/usr/bin/${PN}-cli
"
src_compile() {
	local modlist=( corefreqk=misc:.:build )
	local modargs=( KERNELDIR="${KV_OUT_DIR}" OPTIM_LVL=2 )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	dobin build/corefreqd build/corefreq-cli
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	doinitd "${FILESDIR}/${PN}"
	use systemd && systemd_dounit ${PN}d.service
	use doc && dodoc README.md
}

pkg_postinst() {
	einfo "To be able to use corefreq, you need to:"
	einfo "1. load the kernel module, as root:"
	einfo "   'modprobe corefreqk'"
	einfo "2. start the daemon, as root:"
	einfo "   'corefreqd' or 'rc-service corefreq start' or 'systemctl start corefreqd'"
	einfo "3. start the client, as a user:"
	einfo "   'corefreq-cli'"
}

