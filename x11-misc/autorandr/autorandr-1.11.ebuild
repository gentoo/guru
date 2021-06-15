# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 systemd udev

if [[ "${PV}" = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/phillipberndt/${PN}.git"
else
	SRC_URI="https://github.com/phillipberndt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Automatically select a display configuration based on connected devices"
HOMEPAGE="https://github.com/phillipberndt/autorandr"

LICENSE="GPL-3+"
SLOT="0"
IUSE="bash-completion systemd udev"

DEPEND="
	virtual/pkgconfig
	${RDEPEND}
"
RDEPEND="
	bash-completion? ( app-shells/bash )
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
"

src_install() {
	targets="autorandr autostart_config"
	if use bash-completion; then
		targets="$targets bash_completion"
	fi
	if use systemd; then
		targets="$targets systemd"
	fi
	if use udev; then
		targets="$targets udev"
	fi

	emake DESTDIR="${D}" \
		  install \
		  BASH_COMPLETIONS_DIR="$(get_bashcompdir)" \
		  SYSTEMD_UNIT_DIR="$(systemd_get_systemunitdir)" \
		  UDEV_RULES_DIR="$(get_udevdir)"/rules.d \
		  TARGETS="$targets"
}

pkg_postinst() {
	if use udev; then
		udev_reload
	fi
}
