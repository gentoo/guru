# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PV="$(ver_rs 4 _)"
SANE_CONF_DIR="/etc/sane.d"

DESCRIPTION="HP Unified Linux Driver (for samsung hardware)"
HOMEPAGE="https://support.hp.com"

SRC_URI="
	https://ftp.ext.hp.com/pub/softlib/software13/printers/LaserJet/M437_M443/ULDLINUX_HewlettPackard_V${MY_PV}.zip
"

S="${WORKDIR}/uld"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~mips ~x86"

IUSE="+scanner"

RDEPEND="
	dev-libs/libusb
	net-print/cups
	scanner? (
		media-gfx/sane-backends
	)
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	app-arch/unzip
"

# Do not complain about CFLAGS etc since it is binary package
QA_FLAGS_IGNORED=".*"
QA_PRESTRIPPED="${QA_FLAGS_IGNORED}"

src_unpack() {
	default

	for f in "${WORKDIR}"/*/*.tar.gz; do
		tar -zxf "$f" -C "${WORKDIR}" || die
	done
}

src_install() {
	export AGREE_EULA="y"
	export CONTINUE_INSTALL="y"
	export PAGER="$(which cat)"

	# Fix printer install path
	sed -i "s#\"/opt\"#\"${D}/opt\"#g" noarch/package_utils || die
	sed -i "s#\"/opt\"#\"${D}/opt\"#g" noarch/pre_install.sh || die
	sed -i "s#\"\$INSTDIR_CUPS_BACKENDS\"#\"${D}/\$INSTDIR_CUPS_BACKENDS\"#g" noarch/printer.pkg || die
	sed -i "s#\"\$INSTDIR_CUPS_FILTERS\"#\"${D}/\$INSTDIR_CUPS_FILTERS\"#g" noarch/printer.pkg || die
	sed -i "s#\"\$INSTDIR_CUPS_PPD\"#\"${D}/\$INSTDIR_CUPS_PPD\"#g" noarch/printer-script.pkg || die
	sed -i "s#\"\$INSTDIR_LSB_PPD\"#\"${D}/\$INSTDIR_LSB_PPD\"#g" noarch/printer-script.pkg || die
	# Not use rpm and dpkg
	sed -i "s#which rpm#which not_found_command_${PN}#g" noarch/package_utils || die
	sed -i "s#which dpkg#which not_found_command_${PN}#g" noarch/package_utils || die

	# Fix scanner install path
	sed -i "s#SANE_DIR=/usr/lib\${LIBSFX}/sane#SANE_DIR=${D}/usr/lib\${LIBSFX}/sane#g" noarch/scanner.pkg || die
	sed -i "s#/usr/lib/sane#${D}/usr/lib\${LIBSFX}/sane#g" noarch/scanner.pkg || die
	sed -i "s#/usr/share/locale/\$i/LC_MESSAGES/#${D}//usr/share/locale/\$i/LC_MESSAGES#g" noarch/scanner.pkg || die
	sed -i "s#\$(sane_config)#${D}/\$(sane_config)#g" noarch/scanner-script.pkg || die
	sed -i "s#\$(udev_rules)#${D}/\$(udev_rules)#g" noarch/scanner-script.pkg || die
	sed -i "s#\$(hal_rules)#${D}/\$(hal_rules)#g" noarch/scanner-script.pkg || die
	sed -i "s#\${USERMAP}#${D}/\${USERMAP}#g" noarch/scanner-script.pkg || die
	sed -i "s#		trigger_libusbscanner_hotplug##g" noarch/scanner-script.pkg || die
	mkdir -p "${D}"/etc/hotplug/usb || die

	if use scanner ; then
		echo "# Add support for the HP-ULD specific backend.  Needs net-print/hpuld installed." > "${S}"/"${PN}".conf || die
		echo "smfp" > "${S}"/"${PN}".conf || die
		insinto ${SANE_CONF_DIR}/dll.d
		doins "${S}"/"${PN}".conf

		sh ./install.sh || die
		fperms 644 /etc/sane.d/smfp-hewlett-packard.conf
	else
		sh ./install-printer.sh || die
	fi
}

pkg_postinst() {
	if use scanner ; then
		ewarn "If you want to use the scanner,"
		ewarn "make sure the smfp is listed in ${SANE_CONF_DIR}/dll.d/"${PN}".conf."
		ewarn "If the geniusvp2 is listed in ${SANE_CONF_DIR}/dll.conf,"
		ewarn "please comment out it."

		ewarn "You should restart cupsd service after installed $P."
		ewarn "OpenRC: rc-service cupsd restart"
		ewarn "systemd: systemctl restart cups.service"
	fi
}

pkg_postrm() {
	if use scanner ; then
		ewarn "You should restart cupsd service after removed $P."
		ewarn "OpenRC: rc-service cupsd restart"
		ewarn "systemd: systemctl restart cups.service"
	fi
}
