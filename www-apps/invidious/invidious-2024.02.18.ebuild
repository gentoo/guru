# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs shards systemd

COMMIT="e8a36985aff1a5b33ddf9abea85dd2c23422c2f7"
MOCKS_COMMIT="11ec372f72747c09d48ffef04843f72be67d5b54"
MOCKS_P="${PN}-mocks-${MOCKS_COMMIT:0:7}"
DESCRIPTION="Invidious is an alternative front-end to YouTube"
HOMEPAGE="
	https://invidious.io/
	https://github.com/iv-org/invidious
"
IV_ORG="https://github.com/iv-org"
NPM="https://registry.npmjs.org"
SRC_URI="
	${IV_ORG}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	${NPM}/video.js/-/video.js-7.12.1.tgz
	${NPM}/videojs-contrib-quality-levels/-/videojs-contrib-quality-levels-2.1.0.tgz
	${NPM}/videojs-http-source-selector/-/videojs-http-source-selector-1.1.6.tgz
	${NPM}/videojs-markers/-/videojs-markers-1.0.1.tgz
	${NPM}/videojs-mobile-ui/-/videojs-mobile-ui-0.6.1.tgz
	${NPM}/videojs-overlay/-/videojs-overlay-2.1.4.tgz
	${NPM}/videojs-share/-/videojs-share-3.2.1.tgz
	${NPM}/videojs-vr/-/videojs-vr-1.8.0.tgz
	${NPM}/videojs-vtt-thumbnails/-/videojs-vtt-thumbnails-0.0.13.tgz
	test? (
		${IV_ORG}/mocks/archive/${MOCKS_COMMIT}.tar.gz -> ${MOCKS_P}.tar.gz
	)
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="AGPL-3 Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-db/sqlite:3
	dev-libs/boehm-gc
	dev-libs/libevent:=
	dev-libs/libpcre2:=
	dev-libs/libxml2:2
	dev-libs/libyaml
	dev-libs/openssl:=
	sys-libs/zlib:=
"
RDEPEND="${COMMON_DEPEND}
	acct-user/invidious
	gnome-base/librsvg
"
DEPEND="${COMMON_DEPEND}
	dev-crystal/athena-negotiation
	<dev-crystal/crystal-db-0.12.0
	<dev-crystal/crystal-pg-0.27.0
	dev-crystal/crystal-sqlite3
	~dev-crystal/kemal-1.1.2
	dev-crystal/kilt
	>=dev-crystal/protodec-0.1.5
	test? (
		dev-crystal/spectator
	)
"

DOCS=( {CHANGELOG,README}.md TRANSLATION )

CHECKREQS_MEMORY="2G"

CRYSTAL_DEFINES=(
	-Dskip_videojs_download
	-Ddisable_quic
)

src_unpack() {
	local src depname destname js css

	for src in ${A}; do
		if [[ ${src} == "${P}.tar.gz" ]]; then
			unpack ${src}
		elif [[ ${src} == "${MOCKS_P}.tar.gz" ]]; then
			unpack "${src}"
			mkdir -p "${S}"/mocks || die
			rmdir "${S}"/mocks || die
			mv mocks-${MOCKS_COMMIT} "${S}"/mocks || die
		else
			depname="${src%-*}"

			case ${depname} in
				video.js)
					js="video.js" ;;
				*)
					js="${depname}.js" ;;
			esac

			case ${depname} in
				video.js)
					css="video-js.css" ;;
				videojs-markers)
					css="videojs.markers.css" ;;
				*)
					css="${depname}.css" ;;
			esac

			# Create the destination directory
			destname="${S}/assets/videojs/${depname}"
			mkdir -p "${destname}" || die

			# Create a temporary directory
			mkdir -p "${WORKDIR}"/${depname} || die
			cd "${WORKDIR}"/${depname} || die

			# Copy assets
			unpack ${src}
			cd package/dist || die
			mv ${js} ${destname} || die
			if [[ -f ${css} ]]; then
				mv ${css} ${destname} || die
			fi

			cd "${WORKDIR}" || die
		fi
	done
}

src_prepare() {
	default

	local datadir="${EPREFIX}/usr/share/invidious"
	sed -i src/invidious.cr \
		-e 's/\(CURRENT_BRANCH \) = .*/\1 = "master"/' \
		-e "s/\(CURRENT_COMMIT \) = .*/\1 = \"${COMMIT:0:7}\"/" \
		-e "s/\(CURRENT_VERSION\) = .*/\1 = \"${PV}\"/" \
		-e "s/\(ASSET_COMMIT\) = .*/\1 = \"${COMMIT:0:7}\"/" || die

	# fix paths
	sed -i src/invidious.cr \
		-e "s|\(public_folder\) \"assets\"|\1 \"${datadir}/assets\"|" || die
	sed -i src/invidious/helpers/i18n.cr \
		-e "s|File.read(\"locales/|File.read(\"${datadir}/locales/|" || die
	sed -i src/invidious/database/base.cr \
		-e "s|config/sql|${datadir}/\0|g" || die

	rm shard.lock || die
}

src_install() {
	dobin invidious
	einstalldocs

	insinto /usr/share/invidious
	doins -r assets config locales

	insinto /etc/invidious
	newins config/config.example.yml config.yml

	systemd_dounit "${FILESDIR}"/invidious.service
	newinitd "${FILESDIR}"/invidious.initd ${PN}
	newconfd "${FILESDIR}"/invidious.confd ${PN}
}
