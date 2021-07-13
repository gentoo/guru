# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

RUBY_FAKEGEM_EXTRADOC=""
RUBY_FAKEGEM_GEMSPEC="rspec-wait.gemspec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
USE_RUBY="ruby30 ruby27 ruby26"

inherit ruby-fakegem

DESCRIPTION="enables time-resilient expectations in your RSpec test suite"
HOMEPAGE="https://github.com/laserlemon/rspec-wait"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

ruby_add_rdepend "
	>=dev-ruby/rspec-3
"
