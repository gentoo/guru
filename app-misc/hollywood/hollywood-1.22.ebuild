# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

COMMIT="35275a68c37bbc39d8b2b0e4664a0c2f5451e5f6"

DESCRIPTION="Fill your console with Hollywood melodrama technobabble"
HOMEPAGE="
	https://hollywood.computer
	https://github.com/dustinkirkland/hollywood
"
SRC_URI="https://github.com/dustinkirkland/hollywood/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/byobu
	app-misc/tmux
"

PATCHES=( "${FILESDIR}/${P}-use-libexec.patch" )

src_install() {
	dobin bin/*
	insinto /usr/share
	doins -r share/hollywood
	doins -r share/wallstreet
	doman share/man/man1/hollywood.1
	doman share/man/man1/wallstreet.1
	exeinto /usr/libexec/hollywood
	doexe lib/hollywood/*
	exeinto /usr/libexec/wallstreet
	doexe lib/wallstreet/*
	dodoc README
}

pkg_postinst() {
	optfeature "supported programs" \
	"sys-process/atop \
	net-analyzer/bmon \
	app-misc/cmatrix \
	net-dns/dnstop \
	sys-process/glances \
	sys-process/htop \
	net-analyzer/ifstat \
	sys-process/iotop \
	net-analyzer/iptraf-ng \
	net-analyzer/jnettop \
	sys-process/latencytop \
	net-analyzer/nload \
	sys-process/nmon \
	sys-power/powertop \
	app-admin/sagan \
	net-analyzer/slurm \
	sys-process/tiptop \
	net-analyzer/vnstat \
	app-admin/ccze \
	media-gfx/jp2a \
	sys-apps/mlocate \
	app-text/tree \
	sys-apps/moreutils \
	app-admin/apg \
	net-misc/openssh \
	net-news/newsboat \
	net-news/rsstail \
	net-misc/wget \
	virtual/w3m"
}
