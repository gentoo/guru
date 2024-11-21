# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs linux-info udev

MY_PV="${PV/_p/-}"
MY_P="${PN}-${MY_PV}"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/Whonix/kloak.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Whonix/kloak/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="A privacy tool that makes keystroke biometrics less effective"
HOMEPAGE="https://github.com/Whonix/kloak"

LICENSE="BSD"
SLOT="0"
IUSE="systemd apparmor"

DEPEND="
	dev-libs/libevdev
	dev-libs/libsodium
"
RDEPEND="${DEPEND}"
BDEPEND="app-text/ronn-ng"

PATCHES=(
	"${FILESDIR}/${P}-A-slightly-more-sophisticated-Makefile.patch"
)

pkg_pretend() {
	local CONFIG_CHECK="~UINPUT"
	[[ ${MERGE_TYPE} != buildonly ]] && check_extra_config
}

src_prepare() {
	default

	# force manpages to be regenerated
	rm auto-generated-man-pages/* || die

	# respect our prefix in scripts
	[[ -z "$EPREFIX" ]] || sed -i -e "s!/usr/sbin/!${EPREFIX}/usr/sbin/!" \
		etc/apparmor.d/usr.sbin.kloak \
		usr/lib/systemd/system/kloak.service || die
}

src_configure() {
	tc-export CC PKG_CONFIG
}

src_install() {
	local my_makeopts=(
		prefix="${EPREFIX}/usr"
	)
	use systemd || my_makeopts+=(
		udev_rules_dir=deleteme
		systemd_dir=deleteme
	)
	use apparmor || my_makeopts+=(
		apparmor_dir=deleteme
	)

	emake DESTDIR="${D}" "${my_makeopts[@]}"  install

	if [[ -d "${D}/deleteme" ]]; then
		rm -r "${D}/deleteme" || die
	fi
}

pkg_postinst() {
	if use systemd; then
		elog "systemd kloak service is installed; kloak will automatically restart"
		elog "to handle newly attached each newly attached input device."
	else
		elog "kloak is installed without any service support. You will have"
		elog "to manually launch and stop it, see kloak's documentation:"
		elog "  https://github.com/vmonaco/kloak"
	fi

	use systemd && udev_reload
}

pkg_postrm() {
	use systemd && udev_reload
}
