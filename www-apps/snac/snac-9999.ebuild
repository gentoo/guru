# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A simple, minimalistic ActivityPub instance written in portable C"

HOMEPAGE="https://codeberg.org/grunfink/snac2"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/grunfink/snac2"
else
	SRC_URI="https://codeberg.org/grunfink/snac2/archive/${PV}.tar.gz"
	S="${WORKDIR}/snac2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"

SLOT="0"

IUSE="+mastodon sandbox"

RDEPEND="
	dev-libs/openssl
	net-misc/curl[ssl]
"

DEPEND="${RDEPEND}"

src_compile() {
	local feature_opts=(
		$(usex mastodon '' '-DNO_MASTODON_API')
		$(usex sandbox '-DWITH_LINUX_SANDBOX' '')
	)
	emake CFLAGS="${CFLAGS} ${feature_opts}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${D}"/usr PREFIX_MAN="${D}"/usr/share/man install
}
