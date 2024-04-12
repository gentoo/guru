# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

is_live() {
	[[ ${PV} == 9999 ]]
}

CRATES="
"

if ! is_live; then
	GIT_COMMIT_UEFI_RS="76130a0f1c1585012e598b8c514526bac09c68e0"
	GIT_COMMIT_SMBIOS_LIB="b3e2fff8a6f4b8c2d729467cbbf0c8c41974cd1c"

	declare -A GIT_CRATES=(
		[uefi]="https://github.com/FrameworkComputer/uefi-rs;${GIT_COMMIT_UEFI_RS};uefi-rs-%commit%/uefi"
		[uefi-services]="https://github.com/FrameworkComputer/uefi-rs;${GIT_COMMIT_UEFI_RS};uefi-rs-%commit%/uefi-services"
		[smbios-lib]="https://github.com/FrameworkComputer/smbios-lib;${GIT_COMMIT_SMBIOS_LIB}"
	)
fi

inherit cargo

MY_PN="framework-system"

if is_live; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FrameworkComputer/framework-system.git"
else
	if [[ ${PV} == *_pre* || ${PV} == *_p* ]]; then
		GIT_COMMIT=""
		[[ -n ${GIT_COMMIT} ]] ||
			die "GIT_COMMIT is not defined for snapshot ebuild"
		MY_PV="${GIT_COMMIT}"
		MY_P="${MY_PN}-${MY_PV}"
	else
		MY_PV="v${PV}"
		MY_P="${MY_PN}-${PV}"
	fi

	SRC_URI="
		https://github.com/FrameworkComputer/framework-system/archive/${MY_PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz
		${CARGO_CRATE_URIS}
	"
	S="${WORKDIR}/${MY_P}"

	KEYWORDS="~amd64"
fi

DESCRIPTION="Tool to interact with a Framework Laptop's hardware system"
HOMEPAGE="https://github.com/FrameworkComputer/framework-system"

LICENSE="BSD"
# Crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"

SLOT="0"

RDEPEND="
	virtual/libudev:=
	virtual/libusb:1
"

DEPEND="
	${RDEPEND}
"

DOCS=( README.md support-matrices.md )

# Usual setting for a Rust package
QA_FLAGS_IGNORED="usr/bin/framework_tool"

src_unpack() {
	if is_live; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	default

	# Upstream uses [patch] on some dependencies in Cargo.toml,
	# which are not patched by cargo.eclass's ${ECARGO_HOME}/config
	local crate commit crate_uri crate_dir
	local -a sed_scripts
	for crate in "${!GIT_CRATES[@]}"; do
		IFS=';' read -r \
			crate_uri commit crate_dir <<< "${GIT_CRATES[${crate}]}"
		# Taken from dev-util/difftastic::gentoo ebuilds
		sed_scripts+=(
			"s|^(${crate}[[:space:]]*=[[:space:]]*[{].*)([[:space:]]*git[[:space:]]*=[[:space:]]*['\"][[:graph:]]+['\"][[:space:]]*)(.*[}])|\1path = '${WORKDIR}/${crate_dir//%commit%/${commit}}'\3|;"
			"s|^(${crate}[[:space:]]*=[[:space:]]*[{].*)([,][[:space:]]*branch[[:space:]]*=[[:space:]]*['\"][[:graph:]]+['\"][[:space:]]*)(.*[}])|\1\3|;"
		)
	done
	sed -i -E -e "${sed_scripts[*]}" Cargo.toml ||
		die "Failed to override dependencies in Cargo.toml"
}

src_install() {
	dobin target/release/framework_tool
	einstalldocs
}

pkg_postinst() {
	[[ -n ${REPLACING_VERSIONS} ]] && return
	elog "Framework Laptop 13 Ryzen 7040 Series users might need to"
	elog "follow these steps to use most features of framework_tool:"
	elog
	elog "1. Disable kernel_lockdown(7)"
	elog "2. Run 'framework_tool' with option '--driver portio'"
	elog
	elog "For more information, please consult:"
	elog "  https://github.com/FrameworkComputer/framework-system/issues/20"
}
