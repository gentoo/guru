# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 cmake flag-o-matic

DESCRIPTION="Command Line Interactive and Scriptable Application to access MEGA"
HOMEPAGE="https://github.com/meganz/MEGAcmd"

MEGA_SDK_REV="fae76a36d60484657fbdf442b7b917ccc4fbad77" # commit of sdk submodule
MEGA_TAG_SUFFIX="Linux"
SRC_URI="
	https://github.com/meganz/MEGAcmd/archive/refs/tags/${PV}_${MEGA_TAG_SUFFIX}.tar.gz -> ${P}.tar.gz
	https://github.com/meganz/sdk/archive/${MEGA_SDK_REV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz
"
S="${WORKDIR}"/MEGAcmd-${PV}_${MEGA_TAG_SUFFIX}

LICENSE="BSD-2 GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcre"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/crypto++:=
	dev-libs/icu:=
	dev-libs/libsodium:=
	dev-libs/libuv:=
	dev-libs/openssl:=
	net-misc/curl
	sys-fs/fuse:3=
	sys-libs/readline:=
	virtual/zlib:=
	pcre? ( dev-libs/libpcre )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${P}-cmake4.patch"
	"${FILESDIR}/${P}-disable-vcpkg.patch"
	"${FILESDIR}/${P}-fix-link.patch"
	"${FILESDIR}/${P}-fix-prefix.patch"
	"${FILESDIR}/${P}-rename-libcryptopp.patch"
)

src_prepare() {
	rmdir sdk || die
	mv "${WORKDIR}/sdk-${MEGA_SDK_REV}" sdk || die

	cmake_src_prepare
}

src_configure() {
	# https://github.com/meganz/sdk/issues/2679
	append-cppflags -DNDEBUG

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DFULL_REQS=OFF
		-DUSE_FREEIMAGE=OFF
		-DUSE_PCRE=$(usex pcre)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# https://github.com/meganz/MEGAcmd/blob/4b291975aafa7332ddfbf1a689455ebd972adff4/CMakeLists.txt#L468
	insinto /usr/lib/sysctl.d
	newins - 30-megacmd-inotify-limit.conf <<<"fs.inotify.max_user_watches = 524288"

	newbashcomp src/client/megacmd_completion.sh mega-cmd
	bashcomp_alias mega-cmd mega-{attr,backup,cancel,cat,cd,cmd-server,configure,confirm,confirmcancel,cp,login} \
		mega-{ftp,proxy,fuse-enable,ipc,sync,killsession,passwd,version,invite,log,mount,mv,https,session,share} \
		mega-{tree,sync-ignore,quit,fuse-add,mkdir,pwd,find,exec,transfers,signup,debug,lpwd,help,deleteversions} \
		mega-{sync-issues,exclude,preview,get,fuse-config,whoami,graphics,fuse-remove,webdav,sync-config,rm,reload} \
		mega-{thumbnail,du,put,df,users,permissions,userattr,errorcode,ls,mediainfo,lcd,fuse-disable,export,import} \
		mega-{showpcr,speedlimit,fuse-show,logout}
}
