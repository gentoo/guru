# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="Independent session/login tracker"
HOMEPAGE="https://github.com/chimera-linux/turnstile"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chimera-linux/${PN}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/chimera-linux/turnstile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"

DEPEND="
	sys-libs/pam
	app-text/scdoc
	dinit? (
		sys-apps/dinit
		sys-apps/dinit-services
	)
	runit? (
		sys-process/runit
	)
"
RDEPEND="${DEPEND}"

IUSE="dinit runit rundir man"

src_configure() {
	local emesonargs=(
		$(meson_feature dinit dinit)
		$(meson_feature runit runit)
		$(meson_use rundir manage_rundir)
		$(meson_use man man)
	)
	meson_src_configure
}

pkg_postinst() {
	elog "For Turnstile to work you will have to add the following to /etc/pam.d/system-login"
	elog ""
	elog "-session        optional        pam_turnstile.so"
	elog ""
	elog "You will also need to enable the turnstiled service on dinit or runit"
}
