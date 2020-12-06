# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="This a Ruby gem that delivers a thin and fast web server"
HOMEPAGE="https://github.com/macournoyer/thin"
SRC_URI="https://github.com/macournoyer/thin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-ruby/eventmachine
		dev-ruby/daemons
		dev-ruby/rack"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

each_ruby_configure() {
			${RUBY} -Cext/thin_parser extconf.rb || die
}

each_ruby_compile() {
		emake V=1 -Cext/thin_parser
		cp ext/thin_parser/thin_parser.so lib/ || die
}

all_ruby_install() {
			ruby_fakegem_binwrapper thin
}
