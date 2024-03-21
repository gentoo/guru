# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
PYTHON_REQUIRED_USE="tk"

inherit autotools desktop git-r3 python-single-r1

DESCRIPTION="LinuxCNC"
HOMEPAGE="http://linuxcnc.org/"
#SRC_URI="mirror://sourceforge/gentoocnc/distfiles/${P}.tar.gz"
#SRC_URI="https://github.com/LinuxCNC/linuxcnc/archive/2.7.zip"
EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc.git https://gitclone.com/github.com/LinuxCNC/linuxcnc.git"
S="${WORKDIR}"/linuxcnc-9999/src

LICENSE="LGPL-3"
SLOT="9999"
IUSE="+gtk modbus rt simulator usb +X"
# TODO: add shmdrv use flag

DEPEND="
	${PYTHON_DEPS}

	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/bwidget
	dev-tcltk/tclx
	dev-tcltk/tkimg
	media-gfx/graphviz
	media-libs/mesa
	net-firewall/iptables
	sys-devel/gettext
	sys-process/procps
	sys-process/psmisc
	x11-libs/libXinerama
	x11-apps/mesa-progs
	virtual/glu
	virtual/opengl

	$(python_gen_cond_dep '
		dev-libs/boost[python,${PYTHON_USEDEP}]
		dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[tk,${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
	')

	|| (
		net-analyzer/openbsd-netcat
		net-analyzer/netcat
	)

	modbus? ( <dev-libs/libmodbus-3.1 )
	gtk? ( x11-libs/gtk+ )
	rt? ( sys-kernel/rt-sources )
	usb? ( virtual/libusb )
	X? (
		x11-libs/libXaw
		$(python_gen_cond_dep 'dev-python/python-xlib[${PYTHON_USEDEP}]')
	)
"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep 'dev-python/yapps[${PYTHON_USEDEP}]')
"

RESTRICT="bindist"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	rt? ( !simulator )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-non-distributable=yes
		--with-boost-python=boost_python310
		--with-kernel-headers=/usr/src/linux/
		--with-python="${PYTHON}"
		$(use_with modbus libmodbus)
	)
	use gtk || myconf+=( "--disable-gtk" )
	use rt && myconf+=( "--with-rt-preempt" )
	use simulator && myconf+=( "--with-realtime=uspace" )
	use usb || myconf+=( "--without-libusb-1.0" )
#	use rtai && myconf+=( "--with-realtime=${EPREFIX}/usr/realtime" "--with-module-dir=${EPREFIX}/usr/$(get_libdir)/linuxcnc/rtai/" )
	use X && myconf+=( "--with-x" )

	econf "${myconf[@]}"
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
	elog "Opening machine configuration files from older Versions can crash the application as it cannot load old named modules, e.g. probe_parport.so not found"
	elog "This is not a Gentoo- or build related error. It looks like linuxcnc 2.8 will have some kind of converter for them."
	elog "If you created them with stepconf. You can just open the stepconf file and create them new. Don't forget to backup any manual changes (e.g. backlash!) from the .hal and .ini files and make them again."
}
