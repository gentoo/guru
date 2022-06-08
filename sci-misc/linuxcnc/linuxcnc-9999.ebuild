# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Thanks to the original author's code, slis@gentoo.org's code, because the original code is outdated, this ebuild has been modified portably

EAPI="7"

PYTHON_COMPAT=( python3_10 )

inherit autotools eutils flag-o-matic multilib python-single-r1 git-r3

DESCRIPTION="LinuxCNC "
HOMEPAGE="http://linuxcnc.org/"
#SRC_URI="mirror://sourceforge/gentoocnc/distfiles/${P}.tar.gz"
#SRC_URI="https://github.com/LinuxCNC/linuxcnc/archive/2.7.zip"
EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc.git https://gitclone.com/github.com/LinuxCNC/linuxcnc.git"

S="${WORKDIR}"/linuxcnc-9999/src

LICENSE="LGPL-3"
SLOT="linuxcnc-9999"
KEYWORDS="~amd64 ~x86"
IUSE="+python +uspace +X +gtk -rt gstreamer modbus simulator usb"
# TODO: add shmdrv use flag

# --disable-python uses python anyways and fails so python is a required use flag
REQUIRED_USE="
    python
    python? ( ${PYTHON_REQUIRED_USE} )
	rt? ( !simulator )
	"

DEPEND="dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tkimg
	dev-tcltk/tclx
	dev-libs/boost[python]
	modbus? ( <dev-libs/libmodbus-3.1 )
	dev-tcltk/bwidget
	gtk? ( x11-libs/gtk+ )
    gstreamer? (
        dev-python/gst-python:0.10
        media-libs/gst-plugins-base:0.10
    )
	|| (
        net-analyzer/openbsd-netcat
        net-analyzer/netcat6
    )
	x11-libs/libXinerama
	usb? ( virtual/libusb )
	dev-lang/python:3.10[tk]
	$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/configobj[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pillow[tk,${PYTHON_USEDEP}]')
	media-libs/mesa
    x11-apps/mesa-progs
	X? (
        x11-libs/libXaw
        $(python_gen_cond_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]')
    )
	rt? ( sys-kernel/rt-sources )
	virtual/opengl
	virtual/glu
	${PYTHON_DEPS}
	sys-devel/gettext
	sys-process/procps
    sys-process/psmisc
    net-firewall/iptables
    media-gfx/graphviz
    $(python_gen_cond_dep 'dev-python/pyopengl[${PYTHON_USEDEP}]')
    $(python_gen_cond_dep 'dev-python/pygobject[${PYTHON_USEDEP}]')
    x11-libs/gtksourceview:3.0
"
RDEPEND="${DEPEND}
	python? ( dev-python/yapps )"

src_prepare() {
    default
    eautoreconf
}

src_configure() {
	#myconf="--prefix=${EPREFIX}/usr --with-kernel-headers=/usr/src/linux/ $(use_with modbus libmodbus)"
	myconf="--prefix=${EPREFIX}/usr --enable-non-distributable=yes --with-boost-python=boost_python310 $(use_with modbus libmodbus)"

	use !gtk && myconf="${myconf} --disable-gtk"
	use rt && myconf="${myconf} --with-realtime=uspace"
	use simulator && myconf="${myconf} --with-realtime=uspace"
	use !usb && myconf="${myconf} --without-libusb-1.0"
#	use rtai && myconf="${myconf} --with-realtime=${EPREFIX}/usr/realtime --with-module-dir=${EPREFIX}/usr/lib/linuxcnc/rtai/"
	use X && myconf="${myconf} --with-x"

	# TODO: fix that - get python version
	#use python && myconf="${myconf} --with-python=/usr/bin/python3.10"
	use !python && myconf="${myconf} --disable-python"

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	local envd="${T}/51linuxcnc"
	cat > "${envd}" <<-EOF
		LDPATH="${EPREFIX}/usr/$(get_libdir)/linuxcnc"
	EOF
	doenvd "${envd}"

	insinto "/usr/share/linuxcnc/"
	doins Makefile.inc

	insinto "/etc/linuxcnc/"
	doins "../scripts/rtapi.conf"

	insinto "/usr/bin/"
	doins "../scripts/rip-environment"

	doicon "../linuxcncicon.png"
	make_desktop_entry linuxcnc LinuxCNC linuxcnc 'Science;Robotics'
}

pkg_postinst() {
	elog "The compiled software may not be redistributed due to use of packages with incompatible licenses."
	elog "Opening machine configuration files from older Versions can crash the application as it cannot load old named modules, e.g. probe_parport.so not found"
	elog "This is not a Gentoo- or build related error. It looks like linuxcnc 2.8 will have some kind of converter for them."
	elog "If you created them with stepconf. You can just open the stepconf file and create them new. Don't forget to backup any manual changes (e.g. backlash!) from the .hal and .ini files and make them again."
}
