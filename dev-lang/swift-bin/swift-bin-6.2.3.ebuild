# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..21} )
PYTHON_COMPAT=( python3_{11..14} )
inherit llvm-r1 python-single-r1 unpacker

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"
SWIFT_PF="${PF/-bin/}"
SRC_URI="https://github.com/itaiferber/gentoo-distfiles/releases/download/${CATEGORY}/${SWIFT_PF}/${SWIFT_PF}.gpkg.tar"
S="${WORKDIR}"

LICENSE="Apache-2.0 GPL-2"
SLOT="6/2"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	!~dev-lang/swift-5.10.1:0
	!dev-lang/swift:6/2
	>=app-arch/zstd-1.5
	>=app-eselect/eselect-swift-1.0-r1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.9.1
	>=sys-libs/ncurses-6
	>=virtual/zlib-1.3.1:=
	dev-lang/python
	$(llvm_gen_dep 'llvm-core/lld:${LLVM_SLOT}=')
"

QA_PREBUILT="*"
PKG_PREINST_SWIFT_INTENTIONALLY_SET='true'

src_unpack() {
	unpack_gpkg "${SWIFT_PF}.gpkg.tar"
}

src_install() {
	mv "${SWIFT_PF}/image/usr" "${ED}"
}

pkg_preinst() {
	# After installation, we ideally want the system to have the latest Swift
	# version set -- but if the system already has a Swift version set and it
	# isn't the latest version, that's likely an intentional decision that we
	# don't want to override.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	local latest_swift_version="$(eselect swift show --latest | tail -n1 | xargs)"
	[[ "${current_swift_version}" == '(unset)' ]] \
		|| [[ "${current_swift_version}" == "${latest_swift_version}" ]] \
		&& PKG_PREINST_SWIFT_INTENTIONALLY_SET='false'
}

pkg_postinst() {
	# If the system doesn't have Swift intentionally set to an older version, we
	# can update to the latest.
	if [[ "${PKG_PREINST_SWIFT_INTENTIONALLY_SET}" == 'false' ]]; then
		eselect swift update
	fi

	# We also want to provide a stable directory which matches our SLOT to avoid
	# revdep breakages, as patch updates use the same SLOT but otherwise move
	# the install location on disk.
	#
	# See https://bugs.gentoo.org/957730
	#
	# We do this in `pkg_postinst` instead of calling `dosym` in `src_install`
	# because when upgrading from a major version to a patch version, the major
	# version is still on disk while the patch version is being installed, so
	# the existing directory is in use and the symlink fails to install.
	local major_ver="$(ver_cut 1-2)"
	if [[ "${PV}" != "${major_ver}" ]]; then
		local libdir="${EROOT}/usr/$(get_libdir)"
		ln -fsT "${libdir}/${P}" "${libdir}/${PN}-${major_ver}" || die
	fi
}

pkg_postrm() {
	# We don't want to leave behind symlinks pointing to this Swift version on
	# removal.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	if [[ "${current_swift_version}" == "${P}" ]]; then
		eselect swift update
	fi

	# If we installed a SLOT symlink, we also want to remove it here.
	local major_ver="$(ver_cut 1-2)"
	local link="${EROOT}/usr/$(get_libdir)/${PN}-${major_ver}"
	if [[ -L "${link}" && "${PV}" != "${major_ver}" ]]; then
		rm "${link}"
	fi
}
