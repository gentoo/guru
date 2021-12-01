# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Changes the current Ruby"
HOMEPAGE="https://github.com/postmodern/chruby"
SRC_URI="https://github.com/postmodern/chruby/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DEPEND="|| ( >=app-shells/bash-3.0:* app-shells/zsh )"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	if [ -n "${PVR}" ] ; then
		sed -i Makefile -e "s/^VERSION=${PV}$/VERSION=${PVR}/" \
			|| die "can't fix doc location to follow Gentoo/FHS guidelines"
	fi
}

src_install() {
	# TODO: Remove `${D}` from PREFIX in >=chruby-0.3.10 (https://git.io/JPQ25)
	emake DESTDIR="${D}" PREFIX="${D}/usr" install

	insinto "/etc/profile.d"
	newins "${FILESDIR}/systemwide.sh" "chruby.sh"
}
