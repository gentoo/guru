# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit desktop pax-utils prefix rpm xdg

IUSE="gnome java"

BUILDID="9813"
BVER="${PV/_rc*/}-${BUILDID}"
BVER2=${PV}-${BUILDID}
BASIS="ooobasis4.1"
BASIS2="basis4.1"
NM="openoffice"
NM1="${NM}-brand"
NM2="${NM}4"
NM3="${NM2}.$(ver_cut 2-3)"
FILEPATH="mirror://sourceforge/openofficeorg.mirror"
if [ "${ARCH}" = "amd64" ] ; then
	XARCH="x86_64"
else
	XARCH="i586"
fi
UP="en-US/RPMS"

DESCRIPTION="Apache OpenOffice productivity suite"
HOMEPAGE="https://www.openoffice.org/"
SRC_URI="
	amd64? ( "${FILEPATH}"/Apache_OpenOffice_${PV}_Linux_x86-64_install-rpm_en-US.tar.gz )
	x86? ( "${FILEPATH}"/Apache_OpenOffice_${PV}_Linux_x86_install-rpm_en-US.tar.gz )
"

# TODO: supports ca_XR (Valencian RACV) locale too
LANGS="ast eu bg ca ca-valencia zh-CN zh-TW cs da nl en-GB fi fr gd gl de el he hi hu it ja km ko lt nb pl pt-BR pt ru sr sk sl es sv ta th tr vi"

for X in ${LANGS} ; do
	IUSE="${IUSE} l10n_${X}"
	SRC_URI+=" l10n_${X}? (
		amd64? ( "${FILEPATH}"/Apache_OpenOffice_${PV}_Linux_x86-64_langpack-rpm_${X/ca-valencia/ca-XV}.tar.gz )
		x86? ( "${FILEPATH}"/Apache_OpenOffice_${PV}_Linux_x86_langpack-rpm_${X/ca-valencia/ca-XV}.tar.gz ) )"
done

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	!prefix? ( sys-libs/glibc )
	>=app-accessibility/at-spi2-core-2.46.0
	app-arch/unzip
	app-arch/zip
	>=dev-lang/perl-5.0
	dev-libs/dbus-glib
	media-libs/glu
	>=media-libs/freetype-2.1.10-r2
	media-libs/libglvnd
	sys-libs/ncurses-compat:5
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gdk-pixbuf-xlib
	x11-libs/gtk+:2
	x11-libs/libXaw
	x11-libs/libXinerama
	x11-libs/pango
	x11-libs/libXrandr
"
DEPEND="
	${RDEPEND}
	sys-apps/findutils
"
PDEPEND="java? ( || ( >=virtual/jre-1.8.0 dev-java/openjdk-jre-bin:11 dev-java/openjdk-bin dev-java/openjdk:11 ) )"

RESTRICT="mirror strip"

S="${WORKDIR}"

pkg_setup() {
	QA_PREBUILT="usr/$(get_libdir)/${NM}/program/*"
	QA_TEXTRELS="usr/$(get_libdir)/${NM}/program/libvclplug_genli.so"
}

src_unpack() {
	unpack ${A}

	cp "${FILESDIR}"/{50-${PN},wrapper.in} "${T}" || die
	eprefixify "${T}"/{50-${PN},wrapper.in}

	# 'pyuno' is excluded from unpack list to switch off Python2 scripts support
	for i in base calc core01 core02 core03 core04 core05 core06 core07 draw graphicfilter images impress math ogltrans ooofonts ooolinguistic ure writer xsltfilter ; do
		rpm_unpack "./${UP}/${NM}-${i}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/${NM}-${BVER}.${XARCH}.rpm"

	for j in base calc draw impress math writer; do
		rpm_unpack "./${UP}/${NM1}-${j}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/desktop-integration/${NM3}-freedesktop-menus-${BVER2}.noarch.rpm"

	use gnome && rpm_unpack "./${UP}/${NM}-gnome-integration-${BVER}.${XARCH}.rpm"
	use java && rpm_unpack "./${UP}/${NM}-javafilter-${BVER}.${XARCH}.rpm"

	# English support installed by default
	rpm_unpack "./${UP}/${NM}-en-US-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM1}-en-US-${BVER}.${XARCH}.rpm"
	for s in base calc draw help impress math res writer ; do
		rpm_unpack "./${UP}/${NM}-en-US-${s}-${BVER}.${XARCH}.rpm"
	done

	# Localization
	for l in ${LANGS}; do
		if use l10n_${l}; then
			# Map ca-valencia to ca-XV used by upstream
			case ${l} in
				ca-valencia) m=ca-XV ;;
				*) m=${l} ;;
			esac
			LANGDIR="${m}/RPMS"
			rpm_unpack "./${LANGDIR}/${NM}-${m}-${BVER}.${XARCH}.rpm"
			rpm_unpack "./${LANGDIR}/${NM1}-${m}-${BVER}.${XARCH}.rpm"
			for n in base calc draw help impress math res writer; do
				rpm_unpack "./${LANGDIR}/${NM}-${m}-${n}-${BVER}.${XARCH}.rpm"
			done

		fi
	done
}

src_install() {
	INSTDIR="/usr/$(get_libdir)/${NM}"
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/${NM2}/* "${ED}${INSTDIR}" || die

	#Menu entries, icons and mime-types
	cd "${ED}${INSTDIR}/share/xdg/" || die
	for desk in base calc draw impress javafilter math printeradmin qstart startcenter writer; do
		if [ "${desk}" = "javafilter" ] ; then
			use java || { rm javafilter.desktop; continue; }
		fi
		mv ${desk}.desktop ${NM}-${desk}.desktop || die
		sed -i -e "s/${NM2} /ooffice /g" ${NM}-${desk}.desktop || die
		domenu ${NM}-${desk}.desktop
	done
	insinto /usr/share
	doins -r "${WORKDIR}"/usr/share/icons
	doins -r "${WORKDIR}"/usr/share/mime

	# Make sure the permissions are right
	use prefix || fowners -R root:0 /

	# Install wrapper script
	newbin "${T}/wrapper.in" ooffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${ED}/usr/bin/ooffice" || die

	# Component symlinks
	for app in base calc draw impress math writer; do
		cp "${ED}/usr/bin/ooffice" "${ED}/usr/bin/oo${app}" || die
		sed -i -e s/soffice/s${app}/ "${ED}/usr/bin/oo${app}" || die
	done

	dosym ${INSTDIR}/program/spadmin /usr/bin/ooffice-printeradmin
	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	# Non-java weirdness see bug #99366
	use !java && rm -f "${ED}${INSTDIR}/program/javaldx" "${ED}${INSTDIR}/program/libofficebean.so"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${T}/50-${PN}"

	# remove soffice bin to avoid collision with libreoffice
	rm -rf "${ED}/usr/bin/soffice" || die

	# Vulnerable pythonscript.py, bug #677248
	# Disable python2 script support bug #715400
	rm "${ED}${INSTDIR}/program/python" || die

	# remove obsolete gstreamer-0.10 plugin
	rm "${ED}${INSTDIR}/program/libavmediagst.so" || die
}

pkg_preinst() {
	xdg_pkg_preinst
	use gnome && gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst

	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/${NM}/program/soffice.bin

	# Inform users about python scripting security problems, bug #677248
	# and removing it due to the end of python2 support, bug #715400
	elog "Python2 scripts support via 'pyuno' module was skipped to unpack"
	elog "due to a security vulnerability (CVE-2018-16858)"
	elog "and the end of python2 support in Gentoo."

	# Inform users about changes of encoding of stored passwords in Apache OpenOffice 4.1.14.
	# Notification is from https://cwiki.apache.org/confluence/display/OOOUSERS/AOO+4.1.14+Release+Notes
	ewarn "Important Note:"
	ewarn "It is recommended to make a backup of the Apache OpenOffice users profile"
	ewarn "before installing ${PV}. It is especially essential for users who use"
	ewarn "the Master Password functionality and may decide to use an older version later."
	ewarn "There is a change in the encoding of stored passwords in this ${PV} release"
	ewarn "that may make your user profile unusable for previous versions."
}

pkg_postrm() {
	xdg_pkg_postrm
}
