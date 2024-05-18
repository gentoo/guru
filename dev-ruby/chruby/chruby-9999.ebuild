# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/postmodern/chruby.git"
	inherit git-r3
else
	SRC_URI="https://github.com/postmodern/chruby/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Changes the current Ruby"
HOMEPAGE="https://github.com/postmodern/chruby"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

DEPEND="|| ( >=app-shells/bash-3.0:* app-shells/zsh )"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i Makefile -e "s/^VERSION=.\+$/VERSION=${PVR}/" \
		|| die "can't fix doc location to follow Gentoo/FHS guidelines"
}

src_install() {
	local emakeargs=(
		DESTDIR="$D"
		PREFIX="/usr"
	)

	emake "${emakeargs[@]}" install

	insinto "/etc/profile.d"
	newins "${FILESDIR}/systemwide.sh" "chruby.sh"
}
