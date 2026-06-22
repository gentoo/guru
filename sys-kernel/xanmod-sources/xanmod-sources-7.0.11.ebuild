# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="7"

inherit check-reqs kernel-2
detect_version
detect_arch

MY_P=linux-${PV%.*}
GENPATCHES_P="genpatches-${PV%.*}-${K_GENPATCHES_VER}"
GENPATCHES_URI="
	https://distfiles.gentoo.org/pub/proj/kernel/genpatches/${GENPATCHES_P}.base.tar.xz
	https://distfiles.gentoo.org/pub/proj/kernel/genpatches/${GENPATCHES_P}.extras.tar.xz
"
DESCRIPTION="Full XanMod source, including the Gentoo patchset and other patch options."
HOMEPAGE="https://xanmod.org"

XANMOD_VERSION="1"
XANMOD_URI="https://downloads.sourceforge.net/project/xanmod/releases/main"
OKV="${PV}-xanmod${XANMOD_VERSION}"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${PV%.*}.tar.xz
	${GENPATCHES_URI}
	${XANMOD_URI}/${PV}-xanmod${XANMOD_VERSION}/patch-${PV}-xanmod${XANMOD_VERSION}.xz
"
S="${WORKDIR}/linux-${OKV}"

LICENSE+=" CDDL"
KEYWORDS="~amd64"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_unpack() {
	default
}

src_prepare() {
	eapply "${WORKDIR}/patch-${PV}-xanmod${XANMOD_VERSION}"
	eapply "${FILESDIR}/xanmod-7.0.6-x86-l1-cache-shift-fallback.patch"
	
	rm -f "${WORKDIR}"/2902_Replace-CONST-CAST-with-const-cast.patch 2>/dev/null
	rm -f "${WORKDIR}"/1510_fs-enable-link-security-restrictions-by-default.patch 2>/dev/null
	rm -f "${WORKDIR}"/1730_parisc-Disable-prctl.patch 2>/dev/null
	
	for patch in "${WORKDIR}"/*.patch; do
		[ -f "$patch" ] || continue
		[[ "$patch" == *"2902_Replace"* ]] && continue
		[[ "$patch" == *"1510_fs"* ]] && continue
		[[ "$patch" == *"1730_parisc"* ]] && continue
		eapply "$patch"
	done
	
	rm -f "${S}/tools/testing/selftests/tc-testing/action-ebpf" 2>/dev/null
	
	kernel-2_src_prepare
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-sources with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}