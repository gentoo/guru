# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature edo readme.gentoo-r1

DESCRIPTION="Easy-to-use, feature-packed, protable file server"
HOMEPAGE="https://github.com/9001/copyparty"

SRC_URI="https://github.com/9001/copyparty/releases/download/v${PV}/copyparty-${PV}.tar.gz"

LICENSE="MIT"  # TODO: licenses of copyparty/web/deps
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/jinja2[${PYTHON_USEDEP}]
"
DEPEND="
	test? ( dev-python/strip-hints )
"

DISABLE_AUTOFORMATTING=y
DOC_CONTENTS="\
# TODO: This package is unfinished and lacks some features

- Service scripts:
  - contrib/openrc/copyparty: Hardcodes /usr/local/bin, runs as root, exposes /mnt as RW (!?)
  - contrib/systemd/copyparty.service: Hardcodes /usr/local/bin, runs as root, in /var/lib/copyparty
  - contrib/systemd/copyparty@.service: Runs as an arbitrary user, in /var/lib/copyparty-jail, at boot
  - contrib/systemd/copyparty-user.service: User service, runs in /var/lib/copyparty-jail
  Ideally, both systemd and openrc scripts would have the same behavior.
  I also think it'd be sane to default to a new user/group named copyparty,
  and create /var/lib/copyparty with the correct permissions.

- Default configuration: There's a bunch of examples, find them using:
  \`find docs contrib -name '*.conf'\`.
  Ideally one of these would be installed as /etc/copyparty.conf, and an
  /etc/copyparty.d directory would be created. I'm not sure what would be
  acceptable defaults.

- Jailing the service with prisonparty/bubbleparty: This program is very
  feature-packed, and has a decent security track record, but just has a
  massive attack surface with serious repercussions. Some packages provide a
  'prisonparty' service, which runs the program in a chroot. This script
  hardcodes a lot of things that I'm not sure will work on gentoo, and would
  need matching openrc/systemd services as well.

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
https://gist.github.com/mid-kid/cc7c0c2e1c188c8b135663d547e3dd35"

src_prepare() {
	# Reuse the bundled copy of fusepy for partyfuse
	# patched in scripts/deps-docker/Dockerfile (under "build fusepy")
	sed -e '/from fuse import/s/fuse/copyparty.web.deps.&/' \
		-i bin/partyfuse.py || die

	distutils-r1_src_prepare
}

python_test() {
	edo bash scripts/run-tests.sh python3
}

python_install() {
	distutils-r1_python_install

	# Useful utilities listed in bin/README.md
	# These need to be executed inside the server's data directory
	# Installed into /usr/libexec as not a single other package installs them
	python_scriptinto /usr/libexec/copyparty
	python_doscript bin/partyjournal.py bin/dbtool.py
}

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc

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

	# Additional programs not detected above
	optfeature "automatically generate SSL certificate at startup" app-crypt/cfssl
	optfeature "scrypt password hashing" dev-lang/python[ssl]  # hashlib.scrypt()
}
