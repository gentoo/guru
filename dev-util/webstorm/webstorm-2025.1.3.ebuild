# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper toolchain-funcs

DESCRIPTION="An integrated development environment for JavaScript and related technologies."
HOMEPAGE="https://www.jetbrains.com/webstorm/"
SRC_URI="
	amd64? ( https://download-cdn.jetbrains.com/${PN}/WebStorm-${PV}.tar.gz )
	arm64? ( https://download-cdn.jetbrains.com/${PN}/WebStorm-${PV}-aarch64.tar.gz )
"

LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual )
		Apache-2.0
		BSD
		CC0-1.0
		CDDL
		CDDL-1.1
		EPL-1.0
		GPL-2
		GPL-2-with-classpath-exception
		ISC
		LGPL-2.1
		LGPL-3
		MIT
		MPL-1.1
		OFL-1.1
		ZLIB
"
SLOT="0/2025"
KEYWORDS="~amd64 ~arm64"
IUSE="wayland"

RESTRICT="bindist mirror"
QA_PREBUILT="opt/${P}/*"

BDEPEND="dev-util/debugedit
	dev-util/patchelf
"
RDEPEND="
		dev-libs/wayland
		sys-libs/pam
		sys-libs/zlib
		sys-process/audit
"

src_unpack() {
		# WebStorm unarchived directory is in format WebStorm-xxx.yyy.zzz, not ${P}
		if use amd64 ; then
			cp "${DISTDIR}"/WebStorm-${PV}.tar.gz "${WORKDIR}"/ || die
		elif use arm64 ; then
			cp "${DISTDIR}"/WebStorm-${PV}-aarch64.tar.gz "${WORKDIR}"/ || die
		fi		
		mkdir -p "${P}" || die
		tar --strip-components=1 -xzf "WebStorm-${PV}".tar.gz -C "${P}" || die
}

src_prepare() {
		tc-export OBJCOPY
		default

	if ! use arm64; then
		local remove_me=(
			lib/async-profiler/aarch64
		)
	elif ! use amd64; then
		local remove_me=(
			lib/async-profiler/amd64
		)
	fi

	rm -rv "${remove_me[@]}" || die

	# excepting files that should be kept for remote plugins
	if ! use arm64 ; then
		local skip_remote_files=(
			"plugins/platform-ijent-impl/ijent-aarch64-unknown-linux-musl-release"
			"plugins/gateway-plugin/lib/remote-dev-workers/remote-dev-worker-linux-arm64"
		)
	elif ! use amd64; then
		local skip_remote_files=(
			"plugins/platform-ijent-impl/ijent-x86_64-unknown-linux-musl-release"
			"plugins/gateway-plugin/lib/remote-dev-workers/remote-dev-worker-linux-amd64"
		)
	fi

	# removing debug symbols and relocating debug files as per #876295
	# we're escaping all the files that contain $() in their name
	# as they should not be executed
	find . -type f ! -name '*$(*)*' -print0 | while IFS= read -r -d '' file; do
		for skip in "${skip_remote_files[@]}"; do
			[[ ${file} == ./"${skip}" ]] && continue 2
		done
		if file "${file}" | grep -qE "ELF (32|64)-bit"; then
			${OBJCOPY} --remove-section .note.gnu.build-id "${file}" || die
			debugedit -b "${EPREFIX}/opt/${PN}" -d "/usr/lib/debug" -i "${file}" || die
		fi
	done

		patchelf --set-rpath '$ORIGIN' "jbr/lib/libjcef.so" || die
		patchelf --set-rpath '$ORIGIN' "jbr/lib/jcef_helper" || die

		# As per https://blog.jetbrains.com/platform/2024/07/wayland-support-preview-in-2024-2/ for full wayland support
		if use wayland; then
				echo "-Dawt.toolkit.name=WLToolkit" >> bin/webstorm64.vmoptions || die
		fi
}

src_install() {
		local dir="/opt/${P}"

		insinto "${dir}"
		doins -r *
		fperms 755 "${dir}"/bin/{"${PN}",fsnotifier,format.sh,inspect.sh,jetbrains_client.sh,ltedit.sh,remote-dev-server,remote-dev-server.sh,restarter}
		fperms 755 "${dir}"/jbr/bin/{java,javac,javadoc,jcmd,jdb,jfr,jhsdb,jinfo,jmap,jps,jrunscript,jstack,jstat,jwebserver,keytool,rmiregistry,serialver}
		fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}

		make_wrapper "${PN}" "${dir}"/bin/"${PN}"
		newicon bin/"${PN}".svg "${PN}".svg
		make_desktop_entry "${PN}" "WebStorm ${PV}" "${PN}" "Development;IDE;"

		# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
		insinto /usr/lib/sysctl.d
		newins - 30-"${PN}"-inotify-watches.conf <<<"fs.inotify.max_user_watches = 524288"
}
