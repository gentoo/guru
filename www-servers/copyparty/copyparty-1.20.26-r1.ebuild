# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature edo readme.gentoo-r1 prefix

DESCRIPTION="Easy-to-use, feature-packed, protable file server"
HOMEPAGE="https://github.com/9001/copyparty"

SRC_URI="https://github.com/9001/copyparty/releases/download/v${PV}/copyparty-${PV}.tar.gz"

LICENSE="MIT"  # TODO: licenses of copyparty/web/deps
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	acct-user/copyparty
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/strip-hints
	)
"

DISABLE_AUTOFORMATTING=y
DOC_CONTENTS="\
# OpenRC system service

Simply issue 'rc-service copyparty start'. By default, this will serve
/var/lib/copyparty-jail/srv/, with a file explaining how to further configure
copyparty. You can configure it by modifying the default /etc/copyparty.conf,
and examples are provided in /usr/share/doc/${PF}.

Depending on your filesystem setup, you might want to adapt the service
dependencies through /etc/conf.d/copyparty. For example, add
'rc_use=\"netmount\"' in order to serve network filesystems through copyparty.

It is possible to run copyparty under a different user and group, to do so,
modify the COPYPARTY_USER variable in /etc/conf.d/copyparty.

If you want to run multiple instances of copyparty (for example, under
different users), create a symlink like
'ln -s copyparty /etc/init.d/copyparty.myinstance', and create a copy of the
conf.d file like 'cp /etc/conf.d/copyparty /etc/conf.d/copyparty.myinstance'.
Make sure to change the COPYPARTY_CONFIG variable in conf.d, and use the
separate configuration file to serve a different port, interface/ip address, or
unix socket.

# OpenRC user service

You can start the user service using 'rc-service -U copyparty start'. By
default, this will not host anything. This is because the daemon will
start in \$HOME, and we don't want to accidentally expose private files.
Consider copying and editing the default configuration:
$ install -D /etc/copyparty.conf ~/.config/copyparty/copyparty.conf

If you wish to automatically start this service on boot, but still depend on
system-level services, such as net, netmount or autofs, you will need to make
the entire user depend on them. For example:
$ echo 'rc_use=\"netmount\"' >> /etc/conf.d/user.myuser

Alternatively, you can make the system-wide service run as your user, and
define the service dependencies for it, or even run multiple instances, as
explained in the 'OpenRC system service' section.

# Note about TLS and certificates

This program implements TLS natively, in order to be able to access the
WebCrypto API in browsers[1].

If you intend to expose it to the internet, it's advised to run it through a
reverse proxy[2], like nginx, in order to have a proper TLS implementation, and
more modern transport features.

If that's not an option, by default, the https:// URL will use a builtin,
insecure certificate. Install app-crypt/cfssl in order to have it generate a
custom certificate.

[1]: https://github.com/9001/copyparty/blob/2c26aecd878c185ce358f661d57612f91c21d4b1/copyparty/cert.py#L37-L43
[2]: https://github.com/9001/copyparty#reverse-proxy

# Bundled dependency notice

A few 'web dependencies' are supplied in the copyparty/web/deps directory.
These are mostly things that run in the web browser, such as javascript
libraries, markdown editors, some assets such as fonts, and a sha512 function
implemented in webassembly.

An attempt at rebuilding these was made, but the scripts required too much
patching and should be adapted upstream to be more easily buildable without
docker. Additionally, it's difficult to package npm dependencies in gentoo.
https://gist.github.com/mid-kid/cc7c0c2e1c188c8b135663d547e3dd35

# TODO: This package is unfinished and lacks some features

- Missing service scripts:
-- Systemd system service running as different user/group (default to copyparty)
-- Systemd user service

- Existing upstream service scripts:
-- contrib/systemd/copyparty.service: Hardcodes /usr/local/bin, runs as root, in /var/lib/copyparty
-- contrib/systemd/copyparty@.service: Runs as an arbitrary user, in /var/lib/copyparty-jail, at boot
-- contrib/systemd/copyparty-user.service: User service, runs in /var/lib/copyparty-jail

- Jailing the service with prisonparty/bubbleparty: This program is very
feature-packed, and has a massive attack surface with serious repercussions.
Some packages provide a 'prisonparty' service, which runs the program in a
chroot. This script hardcodes a lot of things that I'm not sure will work on
gentoo, and would need matching openrc/systemd services as well."

src_prepare() {
	# Use a $TMPDIR for testing, not /dev/shm
	sed -e 's/\["\/dev\/shm"[^]]*\]/[]/' \
		-i tests/util.py || die

	# Remove vendored dependencies
	rm -r copyparty/stolen/ifaddr || die  # dev-python/ifaddr
	#rm copyparty/stolen/qrcodegen.py || die  # TODO: not packaged
	rm copyparty/stolen/surrogateescape.py || die  # python2-only dependency

	# Patched dependency (avahi workaround)
	# See https://github.com/9001/copyparty/issues/887#issuecomment-3368575829
	#rm -r copyparty/stolen/dnslib || die

	distutils-r1_src_prepare
}

python_test() {
	edo bash scripts/run-tests.sh python3
}

python_install() {
	distutils-r1_python_install

	# Reuse the bundled copy of mfusepy for partyfuse
	# patched in scripts/deps-docker/Dockerfile (under "build fusepy")
	sed -e "1a$(printf '%s\\n' \
			'import copyparty.web.deps.mfusepy as fuse,sys,os' \
			'sys.path.append(os.path.dirname(fuse.__file__))' \
		)" -i "${D}$(python_get_scriptdir)/partyfuse" || die

	# Useful utilities listed in bin/README.md
	# These need to be executed inside the server's data directory
	# Installed into /usr/libexec as not a single other package installs them
	python_scriptinto /usr/libexec/copyparty
	python_doscript bin/partyjournal.py bin/dbtool.py
}

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc

	# Install service scripts and related files
	newinitd "${FILESDIR}/copyparty.initd" copyparty
	newconfd "${FILESDIR}/copyparty.confd" copyparty
	exeinto /etc/user/init.d
	newexe "${FILESDIR}/copyparty-user-r1.initd" copyparty
	insinto /etc/logrotate.d
	newins "${FILESDIR}/copyparty.logrotate" copyparty
	keepdir /var/log/copyparty

	# Configure default root for system service
	# perfixifying configuration as a courtesy
	hprefixify contrib/systemd/copyparty.conf
	hprefixify contrib/systemd/index.md
	insinto /etc
	doins contrib/systemd/copyparty.conf
	dodoc contrib/systemd/copyparty.example.conf
	insinto /var/lib/copyparty-jail/srv
	doins contrib/systemd/index.md

	# Not all of the documentation is useful, but it's hard to filter,
	# and plenty of it is quite useful.
	dodoc -r docs contrib

	# These additional scripts can be used through command-line flags or
	# configuration files, so it makes sense to put them in a predictable
	# location.  A few of these will require customization, the user should
	# copy them to /etc.
	insinto /usr/share/copyparty
	doins -r bin/handlers bin/hooks bin/mtag

	# Every other package seems to install this, but it needs a service script,
	# as well as proper creation of the jail + testing.
	#newbin bin/prisonparty.sh prisonparty

	# Bubbleparty seems more reasonable, yet I don't see this included in other
	# packages.  Would need an optional sys-apps/bubblewrap dependency.
	#newbin bin/bubbleparty.sh bubbleparty

	# Skipped tools:
	# - bin/partyfuse-streaming.py: Doc tells me this doesn't exist
	# - bin/partyfuse2.py: The regular partyfuse.py is better supported
	# - bin/unforget.py: Not listed in README.md, questionable utility
	# - bin/zmq-recv.py: Not listed in README.md, questionable utility
}

pkg_postinst() {
	# Optfeature descriptions from copyparty/svchub.py:SvcHub._feature_test()
	optfeature "sessions and file/media indexing" dev-lang/python[sqlite]
	optfeature "image thumbnails (plenty fast)" dev-python/pillow
	#optfeature "image thumbnails (faster, eats more ram)" vips  # pyvips not packaged (yet)
	optfeature "create thumbnails as webp files" dev-python/pillow[webp]
	optfeature "transcode audio, create spectrograms, video thumbnails, \
good-but-slow image thumbnails, read audio/media tags" media-video/ffmpeg
	optfeature "read audio tags (ffprobe is better but slower)" media-libs/mutagen
	optfeature "secure password hashing (advanced users only)" dev-python/argon2-cffi
	optfeature "send zeromq messages from event-hooks" dev-python/pyzmq
	optfeature "read .heif images with pillow (rarely useful)" dev-python/pillow-heif
	optfeature "read .avif images with pillow (rarely useful)" dev-python/pillow[avif]
	#optfeature "read RAW images" rawpy  # rawpy not packaged (yet)

	# Other pillow imports not listed above
	optfeature "create thumbnails as jxl files" dev-python/pillow-jxl-plugin

	# Optfeatures from pyproject.toml:project.optional-dependencies not listed above
	optfeature "sftp protocol support" dev-python/paramiko
	optfeature "ftp protocol support" dev-python/pyftpdlib
	optfeature "ftps protocol support" "dev-python/pyftpdlib dev-python/pyopenssl"
	#optfeature "tftp protocol support" partftpy  # partftpy not packaged (yet)

	# Additional programs not detected above
	optfeature "automatically generate SSL certificate at startup" app-crypt/cfssl
	optfeature "scrypt password hashing" dev-lang/python[ssl]  # hashlib.scrypt()
	optfeature "sandbox subprocesses such as ffmpeg" sys-apps/bubblewrap  # --th-bwrap (enabled by default)
}
