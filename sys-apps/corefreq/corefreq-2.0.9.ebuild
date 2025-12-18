# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd toolchain-funcs

DESCRIPTION="CPU monitoring and tuning software designed for 64-bit processors"
HOMEPAGE="https://www.cyring.fr/"
SRC_URI="https://github.com/cyring/CoreFreq/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/CoreFreq-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )

pkg_setup() {
	# see README.md
	# required
	local CONFIG_CHECK="SMP X86_MSR"
	# optional
	local optional_checks=(
		HOTPLUG_CPU
		CPU_IDLE
		CPU_FREQ
		PM_SLEEP
		DMI
		HAVE_NMI
		XEN
		AMD_NB
		HAVE_PERF_EVENTS
		SCHED_MUQSS
		SCHED_BMQ
		SCHED_PDS
	)

	CONFIG_CHECK+="$(printf " ~%s" "${optional_checks[@]}")"

	local check
	for check in "${optional_checks[@]}"; do
		eval "WARNING_${check}"="\"CONFIG_${check} is optional and not enabled\""
	done

	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( corefreqk=misc::build )
	local modargs=( KERNELDIR="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile

	emake V=1 CC="$(tc-getCC)" OPTIM_FLG="${CFLAGS} ${LDFLAGS}" corefreqd corefreq-cli
}

src_install() {
	linux-mod-r1_src_install

	dobin build/{corefreqd,corefreq-cli}
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	doinitd "${FILESDIR}/${PN}"
	systemd_dounit "${PN}d.service"
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	einfo "To be able to use corefreq, you need to load kernel module:"
	einfo "modprobe corefreqk"
	einfo "After that - start daemon with corefreqd"
	einfo "or by 'rc-service corefreq start'"
	einfo "And only after that you can start corefreq-cli"
}
