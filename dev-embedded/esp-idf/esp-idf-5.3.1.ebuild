# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )

VER="13.2.0_20240530"
GDB_VER="14.2_20240403"

CROSSTOOL_URL="https://github.com/espressif/crosstool-NG/releases/download/esp-${VER}"

inherit estack python-r1

DESCRIPTION="Espressif IoT Development Framework"
HOMEPAGE="https://www.espressif.com/"

# See https://dl.espressif.com/dl/esp-idf/espidf.constraints.v5.3.txt for information about version dependencies

SRC_URI="https://dl.espressif.com/github_assets/espressif/${PN}/releases/download/v${PV}/${PN}-v${PV}.zip -> ${P}.zip
	https://github.com/espressif/openocd-esp32/releases/download/v0.12.0-esp32-20240318/openocd-esp32-linux-amd64-0.12.0-esp32-20240318.tar.gz
	https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${GDB_VER}/xtensa-esp-elf-gdb-${GDB_VER}-x86_64-linux-gnu.tar.gz"
SRC_URI+=" ${CROSSTOOL_URL}/xtensa-esp-elf-${VER}-x86_64-linux-gnu.tar.xz"
SRC_URI+=" riscv32? (
	${CROSSTOOL_URL}/riscv32-esp-elf-${VER}-x86_64-linux-gnu.tar.xz
	https://github.com/espressif/binutils-gdb/releases/download/esp-gdb-v${GDB_VER}/riscv32-esp-elf-gdb-${GDB_VER}-x86_64-linux-gnu.tar.gz
)"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="riscv32"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="app-arch/unzip"
RDEPEND="
	${PYTHON_DEPS}

	dev-libs/libusb:1
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/pyelftools[${PYTHON_USEDEP}]
	dev-embedded/esp-coredump[${PYTHON_USEDEP}]
	dev-embedded/esptool
	dev-embedded/esp-idf-kconfig[${PYTHON_USEDEP}]
	dev-embedded/esp-idf-monitor[${PYTHON_USEDEP}]
	dev-embedded/esp-idf-panic-decoder[${PYTHON_USEDEP}]
	dev-embedded/esp-idf-size[${PYTHON_USEDEP}]
	dev-embedded/freertos-gdb[${PYTHON_USEDEP}]
	dev-embedded/idf-component-manager[${PYTHON_USEDEP}]
	sys-libs/zlib
"

RESTRICT="strip"

QA_PREBUILT="opt/* usr/lib* usr/share/esp-idf/*"
QA_PRESTRIPPED="opt/*"

PATCHES=(
	"${FILESDIR}/allow-system-install-${PN}-5.3.patch"
	"${FILESDIR}/${PN}-5.3-fix-cpp-build-eth.patch"
)

install_tool() {
	eshopts_push -s globstar

	into /opt/${1}

	if [[ -d "../${1}/lib" ]]; then
		if stat *.so &>/dev/null; then
		for i in ../${1}/lib/**/*.so*; do
			dolib.so ${i}
		done
		fi

		if stat *.a &>/dev/null; then
		for i in ../${1}/lib/**/*.a*; do
			dolib.a ${i}
		done
		fi

		insinto /opt/${1}/lib
		doins -r ../${1}/lib/*
	fi

	exeinto /opt/${1}/bin
	doexe ../${1}/bin/*
	(
	cd ../${1}
	for i in libexec/**/*; do
		exeinto /opt/${1}/$(dirname ${i})
		if [[ -x "${i}" && ! -d "${i}" ]]; then
			doexe ${i}
		fi
	done

	if [[ -d "include" ]]; then
		insinto /opt/${1}
		doins -r include
	fi

	if [[ -d "share" ]]; then
		insinto /opt/${1}
		doins -r share
	fi
	)

	(
		cd "${D}"/opt/${1}/bin/ || die
		for i in *; do
			dodir /opt/bin
			cd "${D}"/opt/bin || die
			dosym ../${1}/bin/${i} /opt/bin/${i}
		done
	)

	eshopts_pop
}

src_install() {
	echo "v${PV}" > version.txt || die

	newbin - idf <<-EOF
	#!/bin/sh

	# Silence a warning by idf.py
	export IDF_PYTHON_ENV_PATH=
	exec python /usr/share/${PN}/tools/idf.py \$@
EOF

	install_tool xtensa-esp-elf
	install_tool xtensa-esp-elf/xtensa-esp-elf

	if use riscv32; then
		install_tool riscv32-esp-elf
		install_tool riscv32-esp-elf/riscv32-esp-elf
	fi

	install_tool openocd-esp32

	# Remove unsupported python versions
	rm "${WORKDIR}"/xtensa-esp-elf-gdb/bin/xtensa-esp-elf-gdb-3.{8..10} || die
	install_tool xtensa-esp-elf-gdb
	if use riscv32; then
		install_tool riscv32-esp-elf-gdb
	fi

	echo "IDF_PATH=/usr/share/${PN}" > 99esp-idf || die
	doenvd 99esp-idf

	insinto /usr/share/${PN}

	rm -r .git || die
	find . -name ".git" -exec rm -rf {} \; || die
	doins -r .
}
