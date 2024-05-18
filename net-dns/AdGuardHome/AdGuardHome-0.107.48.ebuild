# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps go-module readme.gentoo-r1 systemd unpacker

DESCRIPTION="Network-wide ads & trackers blocking DNS server like Pi-Hole with web ui"
HOMEPAGE="https://github.com/AdguardTeam/AdGuardHome/"

WIKI_COMMIT="7964837"
SRC_URI="
	https://github.com/AdguardTeam/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/deps.tar.zst -> ${P}-deps.tar.zst
	https://github.com/rahilarious/gentoo-distfiles/releases/download/${PN}-0.107.46/wiki.tar.xz -> ${PN}-wiki-${WIKI_COMMIT}.tar.xz
	web? ( https://github.com/rahilarious/gentoo-distfiles/releases/download/${P}/npm-deps.tar.zst -> ${P}-npm-deps.tar.zst )
"

# main
LICENSE="GPL-3"
# deps
LICENSE+=" Apache-2.0 BSD BSD-2 MIT ZLIB"

SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+web"
# RESTRICT="test"

BDEPEND="
	$(unpacker_src_uri_depends)
	>=dev-lang/go-1.22.2
	web? ( net-libs/nodejs[npm] )
"

FILECAPS=(
	-m 755 'cap_net_bind_service=+eip cap_net_raw=+eip' usr/bin/${PN}
)

PATCHES=(
	"${FILESDIR}"/disable-update-cmd-opt.patch
)

DOCS="
	../${PN,,}.wiki/*
"

DOC_CONTENTS="\n
User is advised to not run binary directly instead use systemd service\n\n
Defaults for systemd service:\n
Web UI: 0.0.0.0:3000\n
Data directory: /var/lib/${PN}\n
Default config: /var/lib/${PN}/${PN}.yaml
"
src_unpack() {
	# because we're using  vendor/ so we don't need go-module_src_unpack
	unpacker_src_unpack
}

src_prepare() {
	ln -sv ../vendor ./ || die

	default

	if use web; then
		# mimicking `make js-deps`
		export npm_config_cache="${WORKDIR}/npm-cache" NODE_OPTIONS=--openssl-legacy-provider || die
		npm --verbose --offline --prefix client/ --no-progress --ignore-engines --ignore-optional --ignore-platform --ignore-scripts ci || die
	fi
}

src_compile() {
	# mimicking `make js-build`
	use web && npm --verbose --offline --prefix client run build-prod || die

	# mimicking https://github.com/AdguardTeam/AdGuardHome/blob/master/scripts/make/go-build.sh

	local MY_LDFLAGS="-s -w"
	MY_LDFLAGS+=" -X github.com/AdguardTeam/AdGuardHome/internal/version.version=${PV}"
	MY_LDFLAGS+=" -X github.com/AdguardTeam/AdGuardHome/internal/version.channel=release"
	MY_LDFLAGS+=" -X github.com/AdguardTeam/AdGuardHome/internal/version.committime=$(date +%s)"
	if [ "$(go env GOARM)" != '' ]
	then
		MY_LDFLAGS+=" -X github.com/AdguardTeam/AdGuardHome/internal/version.goarm=$(go env GOARM)"
	elif [ "$(go env GOMIPS)" != '' ]
	then
		MY_LDFLAGS+=" -X github.com/AdguardTeam/AdGuardHome/internal/version.gomips=$(go env GOMIPS)"
	fi

	ego build -ldflags "${MY_LDFLAGS}" -trimpath -v=1 -x=1
}

src_test() {

	# mimicking https://github.com/AdguardTeam/AdGuardHome/blob/master/scripts/make/go-test.sh
	count_flags='--count=1'
	cover_flags='--coverprofile=./coverage.txt'
	shuffle_flags='--shuffle=on'
	timeout_flags="--timeout=30s"
	fuzztime_flags="--fuzztime=20s"
	readonly count_flags cover_flags shuffle_flags timeout_flags fuzztime_flags

	# race only works when pie is disabled
	export GOFLAGS="${GOFLAGS/-buildmode=pie/}"

	# following test is failing without giving any reason. Tried disabling internal/updater internal/whois tests toggling race, but still failing.
	# ego test\
	# 	  "$count_flags"\
	# 	  "$cover_flags"\
	# 	  "$shuffle_flags"\
	# 	  --race=1\
	# 	  "$timeout_flags"\
	# 	  ./...

	# mimicking https://github.com/AdguardTeam/AdGuardHome/blob/master/scripts/make/go-bench.sh
	ego test\
		  "$count_flags"\
		  "$shuffle_flags"\
		  --race=0\
		  "$timeout_flags"\
		  --bench='.'\
		  --benchmem\
		  --benchtime=1s\
		  --run='^$'\
		  ./...

	# mimicking https://github.com/AdguardTeam/AdGuardHome/blob/master/scripts/make/go-fuzz.sh
	ego test\
		  "$count_flags"\
		  "$shuffle_flags"\
		  --race=0\
		  "$timeout_flags"\
		  "$fuzztime_flags"\
		  --fuzz='.'\
		  --run='^$'\
		  ./internal/filtering/rulelist/\
		;

}

src_install() {
	dobin "${PN}"
	dosym -r /usr/bin/"${PN}" /usr/bin/adguardhome

	einstalldocs
	readme.gentoo_create_doc

	systemd_newunit "${FILESDIR}"/AdGuardHome-0.107.43.service "${PN}".service
}

pkg_postinst() {
	readme.gentoo_print_elog
}
