# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCBUILDER="sphinx"
DOCDIR="docs"
AUTODOC=0

PYTHON_COMPAT=( python3_{7,8,9} )

inherit desktop python-r1 docs go-module l10n xdg

EGO_SUM=(
	"0xacab.org/leap/go-dialog v0.0.0-20181123042829-0ee8438431a0"
	"0xacab.org/leap/go-dialog v0.0.0-20181123042829-0ee8438431a0/go.mod"
	"0xacab.org/leap/shapeshifter v0.0.0-20190815154545-f602ba600f5d"
	"0xacab.org/leap/shapeshifter v0.0.0-20190815154545-f602ba600f5d/go.mod"
	"0xacab.org/leap/shapeshifter v0.0.0-20191029173606-85d3e8ac43e2"
	"0xacab.org/leap/shapeshifter v0.0.0-20191029173606-85d3e8ac43e2/go.mod"
	"github.com/AllenDang/w32 v0.0.0-20180428130237-ad0a36d80adc"
	"github.com/AllenDang/w32 v0.0.0-20180428130237-ad0a36d80adc/go.mod"
	"github.com/BurntSushi/freetype-go v0.0.0-20160129220410-b763ddbfe298/go.mod"
	"github.com/BurntSushi/graphics-go v0.0.0-20160129215708-b43f31a4a966/go.mod"
	"github.com/BurntSushi/xgb v0.0.0-20160522181843-27f122750802/go.mod"
	"github.com/BurntSushi/xgbutil v0.0.0-20160919175755-f7c97cef3b4e/go.mod"
	"github.com/BurntSushi/xgbutil v0.0.0-20190907113008-ad855c713046/go.mod"
	"github.com/OperatorFoundation/obfs4 v0.0.0-20161108041644-17f2cb99c264"
	"github.com/OperatorFoundation/obfs4 v0.0.0-20161108041644-17f2cb99c264/go.mod"
	"github.com/OperatorFoundation/shapeshifter-ipc v0.0.0-20170814234159-11746ba927e0"
	"github.com/OperatorFoundation/shapeshifter-ipc v0.0.0-20170814234159-11746ba927e0/go.mod"
	"github.com/OperatorFoundation/shapeshifter-transports v0.0.0-20190827222855-df9bac9654e0"
	"github.com/OperatorFoundation/shapeshifter-transports v0.0.0-20190827222855-df9bac9654e0/go.mod"
	"github.com/OperatorFoundation/shapeshifter-transports v0.0.0-20191101030951-7a751b0500f4"
	"github.com/OperatorFoundation/shapeshifter-transports v0.0.0-20191101030951-7a751b0500f4/go.mod"
	"github.com/ProtonMail/go-autostart v0.0.0-20181114175602-c5272053443a"
	"github.com/ProtonMail/go-autostart v0.0.0-20181114175602-c5272053443a/go.mod"
	"github.com/TheTitanrain/w32 v0.0.0-20180517000239-4f5cfb03fabf/go.mod"
	"github.com/agl/ed25519 v0.0.0-20170116200512-5312a6153412"
	"github.com/agl/ed25519 v0.0.0-20170116200512-5312a6153412/go.mod"
	"github.com/apparentlymart/go-openvpn-mgmt v0.0.0-20161009010951-9a305aecd7f2"
	"github.com/apparentlymart/go-openvpn-mgmt v0.0.0-20161009010951-9a305aecd7f2/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dchest/siphash v1.2.1"
	"github.com/dchest/siphash v1.2.1/go.mod"
	"github.com/getlantern/context v0.0.0-20190109183933-c447772a6520"
	"github.com/getlantern/context v0.0.0-20190109183933-c447772a6520/go.mod"
	"github.com/getlantern/errors v0.0.0-20180829142810-e24b7f4ff7c7"
	"github.com/getlantern/errors v0.0.0-20180829142810-e24b7f4ff7c7/go.mod"
	"github.com/getlantern/errors v0.0.0-20190325191628-abdb3e3e36f7"
	"github.com/getlantern/errors v0.0.0-20190325191628-abdb3e3e36f7/go.mod"
	"github.com/getlantern/golog v0.0.0-20170508214112-cca714f7feb5"
	"github.com/getlantern/golog v0.0.0-20170508214112-cca714f7feb5/go.mod"
	"github.com/getlantern/golog v0.0.0-20190809085441-26e09e6dd330"
	"github.com/getlantern/golog v0.0.0-20190809085441-26e09e6dd330/go.mod"
	"github.com/getlantern/golog v0.0.0-20190830074920-4ef2e798c2d7"
	"github.com/getlantern/golog v0.0.0-20190830074920-4ef2e798c2d7/go.mod"
	"github.com/getlantern/hex v0.0.0-20160523043825-083fba3033ad"
	"github.com/getlantern/hex v0.0.0-20160523043825-083fba3033ad/go.mod"
	"github.com/getlantern/hex v0.0.0-20190417191902-c6586a6fe0b7"
	"github.com/getlantern/hex v0.0.0-20190417191902-c6586a6fe0b7/go.mod"
	"github.com/getlantern/hidden v0.0.0-20160523043807-d52a649ab33a"
	"github.com/getlantern/hidden v0.0.0-20160523043807-d52a649ab33a/go.mod"
	"github.com/getlantern/hidden v0.0.0-20190325191715-f02dbb02be55"
	"github.com/getlantern/hidden v0.0.0-20190325191715-f02dbb02be55/go.mod"
	"github.com/getlantern/ops v0.0.0-20170904182230-37353306c908"
	"github.com/getlantern/ops v0.0.0-20170904182230-37353306c908/go.mod"
	"github.com/getlantern/ops v0.0.0-20190325191751-d70cb0d6f85f"
	"github.com/getlantern/ops v0.0.0-20190325191751-d70cb0d6f85f/go.mod"
	"github.com/getlantern/systray v0.0.0-20190626064521-f2fa635d0474"
	"github.com/getlantern/systray v0.0.0-20190626064521-f2fa635d0474/go.mod"
	"github.com/getlantern/systray v0.0.0-20190727060347-6f0e5a3c556c"
	"github.com/getlantern/systray v0.0.0-20190727060347-6f0e5a3c556c/go.mod"
	"github.com/getlantern/systray v0.0.0-20191102120558-baeca33b8639"
	"github.com/getlantern/systray v0.0.0-20191102120558-baeca33b8639/go.mod"
	"github.com/go-stack/stack v1.8.0"
	"github.com/go-stack/stack v1.8.0/go.mod"
	"github.com/gotk3/gotk3 v0.0.0-20190108052711-d09d58ef3476"
	"github.com/gotk3/gotk3 v0.0.0-20190108052711-d09d58ef3476/go.mod"
	"github.com/gotk3/gotk3 v0.0.0-20190809225113-dc58eba1cccc"
	"github.com/gotk3/gotk3 v0.0.0-20190809225113-dc58eba1cccc/go.mod"
	"github.com/gotk3/gotk3 v0.0.0-20191027191019-60cba67d4ea4"
	"github.com/gotk3/gotk3 v0.0.0-20191027191019-60cba67d4ea4/go.mod"
	"github.com/jmshal/go-locale v0.0.0-20161107082030-4f541412d67a"
	"github.com/jmshal/go-locale v0.0.0-20161107082030-4f541412d67a/go.mod"
	"github.com/jmshal/go-locale v0.0.0-20190124211249-eb00fb25cc61"
	"github.com/jmshal/go-locale v0.0.0-20190124211249-eb00fb25cc61/go.mod"
	"github.com/kardianos/osext v0.0.0-20190222173326-2bc1f35cddc0"
	"github.com/kardianos/osext v0.0.0-20190222173326-2bc1f35cddc0/go.mod"
	"github.com/keybase/go-ps v0.0.0-20190827175125-91aafc93ba19"
	"github.com/keybase/go-ps v0.0.0-20190827175125-91aafc93ba19/go.mod"
	"github.com/mattn/go-gtk v0.0.0-20180216084204-5a311a1830ab/go.mod"
	"github.com/mattn/go-gtk v0.0.0-20190405072524-4deadb416788/go.mod"
	"github.com/mattn/go-gtk v0.0.0-20191030024613-af2e013261f5/go.mod"
	"github.com/mattn/go-pointer v0.0.0-20171114154726-1d30dc4b6f28/go.mod"
	"github.com/mattn/go-pointer v0.0.0-20180825124634-49522c3f3791/go.mod"
	"github.com/mattn/go-pointer v0.0.0-20190911064623-a0a44394634f/go.mod"
	"github.com/oxtoacart/bpool v0.0.0-20150712133111-4e1c5567d7c2"
	"github.com/oxtoacart/bpool v0.0.0-20150712133111-4e1c5567d7c2/go.mod"
	"github.com/oxtoacart/bpool v0.0.0-20190530202638-03653db5a59c"
	"github.com/oxtoacart/bpool v0.0.0-20190530202638-03653db5a59c/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sevlyar/go-daemon v0.1.5"
	"github.com/sevlyar/go-daemon v0.1.5/go.mod"
	"github.com/skelterjohn/go.wde v0.0.0-20180104102407-a0324cbf3ffe/go.mod"
	"github.com/skelterjohn/go.wde v0.0.0-20190318181201-adc3f78cdb45/go.mod"
	"github.com/skratchdot/open-golang v0.0.0-20190104022628-a2dfa6d0dab6"
	"github.com/skratchdot/open-golang v0.0.0-20190104022628-a2dfa6d0dab6/go.mod"
	"github.com/skratchdot/open-golang v0.0.0-20190402232053-79abb63cd66e"
	"github.com/skratchdot/open-golang v0.0.0-20190402232053-79abb63cd66e/go.mod"
	"github.com/sqweek/dialog v0.0.0-20190728103509-6254ed5b0d3c"
	"github.com/sqweek/dialog v0.0.0-20190728103509-6254ed5b0d3c/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.2.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/yuin/goldmark v1.1.27/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20191105034135-c7e5f84aec59"
	"golang.org/x/crypto v0.0.0-20191105034135-c7e5f84aec59/go.mod"
	"golang.org/x/mod v0.2.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190813141303-74dc4d7220e7"
	"golang.org/x/net v0.0.0-20190813141303-74dc4d7220e7/go.mod"
	"golang.org/x/net v0.0.0-20191105084925-a882066a44e0"
	"golang.org/x/net v0.0.0-20191105084925-a882066a44e0/go.mod"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa"
	"golang.org/x/sys v0.0.0-20190804053845-51ab0e2deafa/go.mod"
	"golang.org/x/sys v0.0.0-20190813064441-fde4db37ae7a"
	"golang.org/x/sys v0.0.0-20190813064441-fde4db37ae7a/go.mod"
	"golang.org/x/sys v0.0.0-20191104094858-e8c54fb511f6/go.mod"
	"golang.org/x/sys v0.0.0-20191105142833-ac3223d80179"
	"golang.org/x/sys v0.0.0-20191105142833-ac3223d80179/go.mod"
	"golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4"
	"golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190806143415-35ef2682e516"
	"golang.org/x/tools v0.0.0-20190806143415-35ef2682e516/go.mod"
	"golang.org/x/tools v0.0.0-20190815235612-5b08f89bfc0c/go.mod"
	"golang.org/x/tools v0.0.0-20191104232314-dc038396d1f0"
	"golang.org/x/tools v0.0.0-20191104232314-dc038396d1f0/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20200427153019-a90b7300be7c"
	"golang.org/x/tools v0.0.0-20200427153019-a90b7300be7c/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.5/go.mod"
)

go-module_set_globals

DESCRIPTION="Anonymous encrypted VPN client powered by Bitmask"
HOMEPAGE="https://bitmask.net https://0xacab.org/leap/bitmask-vpn https://riseup.net/en/vpn"
SRC_URI="https://0xacab.org/leap/bitmask-vpn/-/archive/${PV}/bitmask-vpn-${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

# Save a lot of Error 404's since this is not mirrored
# Tests require internet access to connect to Riseup Networks
RESTRICT="mirror test"

# Generated with dev-go/golicense
LICENSE="GPL-3 BSD-2 CC0-1.0 MIT BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

PLOCALES="ar bn br ca de el en-GB en-US en es-ES es eu fa-IR fr he hu it lt nl pl pt-BR pt-PT ro ru sk sv tr ug zh-TW zh"

QA_PRESTRIPPED="
	/usr/bin/bitmask-vpn
	/usr/bin/bitmask-helper
	/usr/bin/bitmask-connect
"

BDEPEND="
	dev-go/go-text
	dev-libs/libappindicator:3
	dev-util/debhelper
	sys-apps/fakeroot
	virtual/pkgconfig
	x11-libs/gtk+:3
	doc? ( $(python_gen_any_dep 'dev-python/alabaster[${PYTHON_USEDEP}]') )
"

RDEPEND="
	net-vpn/openvpn
	sys-auth/polkit
"

# ip command is in bin instead of sbin on Gentoo
PATCHES=( "${FILESDIR}/${PN}-ip-location.patch" )

# Need gotext in path
PATH="/usr/lib/go/bin:${PATH}"

S="${WORKDIR}/bitmask-vpn-${PV}"

src_compile() {
	emake build || die

	docs_compile
}

src_install() {
	einstalldocs

	dobin "build/bin/linux/bitmask-connect" || die
	dobin "build/bin/linux/bitmask-helper" || die
	dobin "build/bin/linux/bitmask-vpn" || die
	dosym "bitmask-vpn" "/usr/bin/riseup-vpn" || die

	python_scriptinto /usr/sbin
	python_foreach_impl python_doscript "helpers/bitmask-root" || die

	insinto /usr/share/polkit-1/actions
	doins "helpers/se.leap.bitmask.policy" || die

	newicon -s scalable "branding/assets/riseup/icon.svg" riseup.svg
	make_desktop_entry "${PN}" RiseupVPN riseup Network
}

pkg_postinst() {
	xdg_pkg_postinst
	go-module_pkg_postinst
}
