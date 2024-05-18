# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kernel-build toolchain-funcs

MY_P=linux-${PV%.*}
GENPATCHES_P=genpatches-${PV%.*}-$(( ${PV##*.} + 0 ))
# https://koji.fedoraproject.org/koji/packageinfo?packageID=8
# forked to https://github.com/projg2/fedora-kernel-config-for-gentoo
CONFIG_VER=6.0.8-gentoo
GENTOO_CONFIG_VER=g3

DESCRIPTION="Linux kernel built with Gentoo patches"
HOMEPAGE="https://www.kernel.org/"
SRC_URI+="
	https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~alicef/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~alicef/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	https://github.com/projg2/gentoo-kernel-config/archive/${GENTOO_CONFIG_VER}.tar.gz
		-> gentoo-kernel-config-${GENTOO_CONFIG_VER}.tar.gz
	amd64? (
		https://raw.githubusercontent.com/projg2/fedora-kernel-config-for-gentoo/${CONFIG_VER}/kernel-x86_64-fedora.config
			-> kernel-x86_64-fedora.config.${CONFIG_VER}
	)
	arm64? (
		https://raw.githubusercontent.com/projg2/fedora-kernel-config-for-gentoo/${CONFIG_VER}/kernel-aarch64-fedora.config
			-> kernel-aarch64-fedora.config.${CONFIG_VER}
	)
	ppc64? (
		https://raw.githubusercontent.com/projg2/fedora-kernel-config-for-gentoo/${CONFIG_VER}/kernel-ppc64le-fedora.config
			-> kernel-ppc64le-fedora.config.${CONFIG_VER}
	)
	x86? (
		https://raw.githubusercontent.com/projg2/fedora-kernel-config-for-gentoo/${CONFIG_VER}/kernel-i686-fedora.config
			-> kernel-i686-fedora.config.${CONFIG_VER}
	)
"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug hardened pic static +hostfs +iomem"
REQUIRED_USE="arm? ( savedconfig )
	hppa? ( savedconfig )
	riscv? ( savedconfig )"

RDEPEND="
	sys-apps/usermode-utilities
"
BDEPEND="
	debug? ( dev-util/pahole )
"

QA_FLAGS_IGNORED="
	usr/src/linux-.*/scripts/gcc-plugins/.*.so
	usr/src/linux-.*/vmlinux
	usr/src/linux-.*/arch/powerpc/kernel/vdso.*/vdso.*.so.dbg
"

src_prepare() {
	local PATCHES=(
		# meh, genpatches have no directory
		"${WORKDIR}"/*.patch
	)
	default

	local biendian=false

	# prepare the default config
	case ${ARCH} in
		amd64)
			cp "${DISTDIR}/kernel-x86_64-fedora.config.${CONFIG_VER}" .config || die
			;;
		arm)
			return
			;;
		arm64)
			cp "${DISTDIR}/kernel-aarch64-fedora.config.${CONFIG_VER}" .config || die
			biendian=true
			;;
		hppa)
			return
			;;
		ppc)
			# assume powermac/powerbook defconfig
			# we still package.use.force savedconfig
			cp "${WORKDIR}/${MY_P}/arch/powerpc/configs/pmac32_defconfig" .config || die
			;;
		ppc64)
			cp "${DISTDIR}/kernel-ppc64le-fedora.config.${CONFIG_VER}" .config || die
			biendian=true
			;;
		riscv)
			return
			;;
		x86)
			cp "${DISTDIR}/kernel-i686-fedora.config.${CONFIG_VER}" .config || die
			;;
		*)
			die "Unsupported arch ${ARCH}"
			;;
	esac

	local myversion="-usermode-gentoo"
	use hardened && myversion+="-hardened"
	echo "CONFIG_LOCALVERSION=\"${myversion}\"" > "${T}"/version.config || die
	local dist_conf_path="${WORKDIR}/gentoo-kernel-config-${GENTOO_CONFIG_VER}"

	local merge_configs=(
		"${T}"/version.config
		"${dist_conf_path}"/base.config
	)
	use debug || merge_configs+=(
		"${dist_conf_path}"/no-debug.config
	)
	if use hardened; then
		merge_configs+=( "${dist_conf_path}"/hardened-base.config )

		tc-is-gcc && merge_configs+=( "${dist_conf_path}"/hardened-gcc-plugins.config )

		if [[ -f "${dist_conf_path}/hardened-${ARCH}.config" ]]; then
			merge_configs+=( "${dist_conf_path}/hardened-${ARCH}.config" )
		fi
	fi

	# this covers ppc64 and aarch64_be only for now
	if [[ ${biendian} == true && $(tc-endian) == big ]]; then
		merge_configs+=( "${dist_conf_path}/big-endian.config" )
	fi

	kernel-build_merge_configs "${merge_configs[@]}"
}

src_configure() {
	default

	MAKEARGS+=( ARCH="um" )

	if use pic; then
		MAKEARGS+=( KCFLAGS="-fPIC" )
	fi

	restore_config .config
	emake O="${WORKDIR}"/modprep "${MAKEARGS[@]}" mrproper
	mv .config "${WORKDIR}"/modprep/.config || die

	# UML
	if use static; then
		echo "CONFIG_STATIC_LINK=y" >> "${WORKDIR}"/modprep/.config || die
	fi
	if use hostfs; then
		echo "CONFIG_HOSTFS=y" >> "${WORKDIR}"/modprep/.config || die
	fi
	if use iomem; then
		echo "CONFIG_MMAPPER=y" >> "${WORKDIR}"/modprep/.config || die
	fi
	echo "CONFIG_UML_TIME_TRAVEL_SUPPORT=y" >> "${WORKDIR}"/modprep/.config || die

	# Character Devices
	echo "CONFIG_STDERR_CONSOLE=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_SSL=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_NULL_CHAN=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_PORT_CHAN=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_PTY_CHAN=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_TTY_CHAN=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_XTERM_CHAN=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_UML_SOUND=y" >> "${WORKDIR}"/modprep/.config || die

	# Network Devices
	echo "CONFIG_UML_NET=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_UML_NET_VECTOR=y" >> "${WORKDIR}"/modprep/.config || die

	# Kernel
	echo "CONFIG_VIRTIO_UML=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_UML_RTC=y" >> "${WORKDIR}"/modprep/.config || die

	# Block Devices
	echo "CONFIG_BLK_DEV_UBD=y" >> "${WORKDIR}"/modprep/.config || die
	echo "CONFIG_BLK_DEV_UBD_SYNC=y" >> "${WORKDIR}"/modprep/.config || die

	# Watchdog Timer
	echo "CONFIG_UML_WATCHDOG=y" >> "${WORKDIR}"/modprep/.config || die

	# Character Devices
	echo "CONFIG_UML_RANDOM=y" >> "${WORKDIR}"/modprep/.config || die

	emake O="${WORKDIR}"/modprep "${MAKEARGS[@]}" olddefconfig
	emake O="${WORKDIR}"/modprep "${MAKEARGS[@]}" modules_prepare
	cp -pR "${WORKDIR}"/modprep "${WORKDIR}"/build || die
}

src_compile() {
	emake O="${WORKDIR}"/build "${MAKEARGS[@]}" all
}

src_install() {
	# do not use 'make install' as it behaves differently based
	# on what kind of installkernel is installed
	local targets=( modules_install )

	emake O="${WORKDIR}"/build "${MAKEARGS[@]}" \
		INSTALL_MOD_PATH="${ED}" INSTALL_PATH="${ED}/boot" "${targets[@]}"

	# note: we're using mv rather than doins to save space and time
	# install main and arch-specific headers first, and scripts
	local kern_arch="um"
	local mods_arch="x86" # hardcoded!
	local dir_ver=${PV}${KV_LOCALVERSION}
	local kernel_dir=/usr/src/linux-${dir_ver}
	dodir "${kernel_dir}/arch/${kern_arch}"
	dodir "${kernel_dir}/arch/${mods_arch}"
	mv include scripts "${ED}${kernel_dir}/" || die
	mv "arch/${kern_arch}/include" \
		"${ED}${kernel_dir}/arch/${kern_arch}/" || die
	mv "arch/${mods_arch}/include" \
		"${ED}${kernel_dir}/arch/${mods_arch}/" || die

	# remove everything but Makefile* and Kconfig*
	find -type f '!' '(' -name 'Makefile*' -o -name 'Kconfig*' ')' \
		-delete || die
	find -type l -delete || die
	cp -p -R * "${ED}${kernel_dir}/" || die

	cd "${WORKDIR}" || die
	# strip out-of-source build stuffs from modprep
	# and then copy built files as well
	find modprep -type f '(' \
			-name Makefile -o \
			-name '*.[ao]' -o \
			'(' -name '.*' -a -not -name '.config' ')' \
		')' -delete || die
	rm modprep/source || die
	cp -p -R modprep/. "${ED}${kernel_dir}"/ || die

	# install the kernel and files needed for module builds
	insinto "${kernel_dir}"
	doins build/{System.map,Module.symvers}
	local image_path="linux"
	cp -p "build/${image_path}" "${ED}${kernel_dir}/${image_path}" || die

	# building modules fails with 'vmlinux has no symtab?' if stripped
	use ppc64 && dostrip -x "${kernel_dir}/${image_path}"

	# Install vmlinux with debuginfo when requested
	if use debug; then
		if [[ "${image_path}" != "linux" ]]; then
			mv "build/linux" "${ED}${kernel_dir}/linux" || die
		fi
		dostrip -x "${kernel_dir}/linux"
	fi
	dobin "${kernel_dir}/linux"

	# strip empty directories
	find "${D}" -type d -empty -exec rmdir {} + || die

	local relfile=${ED}${kernel_dir}/include/config/kernel.release
	local module_ver
	module_ver=$(<"${relfile}") || die

	# fix source tree and build dir symlinks
	dosym "../../../${kernel_dir}" "/lib/modules/${module_ver}/build"
	dosym "../../../${kernel_dir}" "/lib/modules/${module_ver}/source"

	save_config build/.config
}

pkg_postinst() {
	# disable kernel-install_pkg_postinst
	setcap cap_net_admin+ep "/usr/bin/linux" || die
}

pkg_prerm() {
	# disable kernel-install_pkg_prerm
	true
}

pkg_postrm() {
	# disable kernel-install_pkg_postrm
	true
}
