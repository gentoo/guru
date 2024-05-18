# Copyright 2013-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit fcaps linux-info python-r1 toolchain-funcs

DESCRIPTION="Linux x86 CPU power tools"
HOMEPAGE="https://www.kernel.org/"
SRC_URI="https://cdn.kernel.org/pub/linux/kernel/v${PV%%.*}.x/linux-${PV}.tar.xz"
S="${WORKDIR}/linux-${PV}"

LICENSE="GPL-2"
SLOT="0/0"
KEYWORDS="~amd64"
IUSE="pstate-tracer"

CDEPEND="dev-libs/libnl:3"
RDEPEND="
	pstate-tracer? (
		${PYTHON_DEPS}
		dev-python/gnuplot-py[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		sci-visualization/gnuplot
	)
"
DEPEND="
	${CDEPEND}
	virtual/os-headers
"

REQUIRED_USE="pstate-tracer? ( ${PYTHON_REQUIRED_USE} )"

PATCHES=( "${FILESDIR}/${P}-cflags.patch" )
FILECAPS=( 'cap_sys_rawio=ep' usr/bin/turbostat )

pkg_setup() {
	linux-info_pkg_setup
	if linux_config_exists; then
		CONFIG_CHECK_MODULES="CONFIG_X86_MSR" || ewarn "msr module is needed at runtime"
	fi
}

src_configure() {
	export bindir="${EPREFIX}/usr/bin"
	export sbindir="${EPREFIX}/usr/sbin"
	export mandir="${EPREFIX}/usr/share/man"
	export includedir="${EPREFIX}/usr/include"
	export libdir="${EPREFIX}/usr/$(get_libdir)"
	export localedir="${EPREFIX}/usr/share/locale"
	export docdir="${EPREFIX}/usr/share/doc/${PF}"
	export confdir="${EPREFIX}/etc"
	export bash_completion_dir="${EPREFIX}/usr/share/bash-completion/completions"
	export V=1
}

src_compile() {
	myemakeargs=(
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		LD="$(tc-getCC)"
		VERSION=${PV}
	)
	emake -C tools/power/x86/intel-speed-select "${myemakeargs[@]}"
	emake -C tools/power/x86/turbostat "${myemakeargs[@]}"
	emake -C tools/power/x86/x86_energy_perf_policy "${myemakeargs[@]}"
}

src_install() {
	pushd "${S}/tools/power/x86/intel-speed-select" || die
	emake "${myemakeargs[@]}" DESTDIR="${D}" install
	popd || die
	pushd "${S}/tools/power/x86/turbostat" || die
	emake "${myemakeargs[@]}" DESTDIR="${D}" install
	popd || die
	pushd "${S}/tools/power/x86/x86_energy_perf_policy" || die
	emake "${myemakeargs[@]}" DESTDIR="${D}" install
	popd || die

	if use pstate-tracer; then
		python_foreach_impl python_doscript tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
		python_foreach_impl python_doscript tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
	fi

	einstalldocs
}

pkg_postinst() {
	fcaps_pkg_postinst
}
