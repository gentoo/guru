# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
USE_RUBY="ruby26"

inherit ruby-fakegem

DESCRIPTION="This a Ruby gem that delivers a thin and fast web server"
HOMEPAGE="https://github.com/macournoyer/thin"
SRC_URI="https://github.com/macournoyer/thin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

ruby_add_depend "
	dev-ruby/eventmachine
	dev-ruby/daemons
	dev-ruby/rack
"

all_ruby_prepare() {
	# Fix Ragel-based parser generation (uses a *very* old syntax that
	# is not supported in Gentoo)
	sed -i -e 's: | rlgen-cd::' Rakefile || die

	# Fix specs' dependencies so that the extension is not rebuilt
	# when running tests
	rm tasks/spec.rake || die

	# Fix rspec version to allow newer 2.x versions
	sed -i -e '/gem "rspec"/ s/1.2.9/2.0/' spec/spec_helper.rb || die

	# Avoid CLEAN since it may not be available and we don't need it.
	sed -i -e '/CLEAN/ s:^:#:' tasks/*.rake || die

	# Disable a test that is known for freezing the testsuite,
	# reported upstream. In thin 1.5.1 this just fails.
	sed -i \
		-e '/should force kill process in pid file/,/^  end/ s:^:#:' \
		spec/daemonizing_spec.rb || die

	sed -i \
		-e '/tracing routines (with NO custom logger)/,/^  end/ s:^:#:'\
		spec/logging_spec.rb || die

	# Remove failing perfomance tests
	rm -r spec/perf || die

	sed -i -e "s/Spec::Runner/Rspec/" spec/spec_helper.rb || die
	# nasty but too complex to fix up for now :(
	if ! use doc; then
		rm tasks/rdoc.rake || die
	fi
}

each_ruby_configure() {
	${RUBY} -Cext/thin_parser extconf.rb || die
}

each_ruby_compile() {
	emake V=1 CFLAGS="${CFLAGS} -fPIC" DLDFLAGS="${LDFLAGS}" -Cext/thin_parser
	cp ext/thin_parser/thin_parser.so lib/ || die
}

all_ruby_install() {
	ruby_fakegem_binwrapper thin
}

all_ruby_install() {
	all_fakegem_install

	keepdir /etc/thin
	newinitd "${FILESDIR}/${PN}.initd-r4" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd-2" "${PN}"

	einfo
	elog "Thin is now shipped with init scripts."
	elog "The default script (/etc/init.d/thin) will start all servers that have"
	elog "configuration files in /etc/thin/. You can symlink the init script to"
	elog "files of the format 'thin.SERVER' to be able to start individual servers."
	elog "See /etc/conf.d/thin for more configuration options."
	einfo
}
