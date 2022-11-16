# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

require "yaml"

yaml = File.open("shard.yml") do |file|
  YAML.parse(file)
end

puts yaml["name"].as_s
