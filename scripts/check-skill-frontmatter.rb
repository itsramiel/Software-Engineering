#!/usr/bin/env ruby
# frozen_string_literal: true

# Checks that every SKILL.md under a folder starts with YAML frontmatter that
# parses to a map. Prints one GitHub Actions error annotation per failing file
# and exits 1 if any file fails.
#
# Usage: ruby scripts/check-skill-frontmatter.rb [root]
#
# root defaults to the repo's skills folder.

require "pathname"
require "psych"

DELIMITER = "---"
DEFAULT_ROOT = File.expand_path("../skills", __dir__)

Failure = Struct.new(:path, :line, :message)

# Records where the last parsed event ended, so a syntax error can point past
# it. Psych::SyntaxError#line holds the start of the enclosing block when the
# parser has one, which for a block mapping is the first key, not the bad line.
class LocationTrackingBuilder < Psych::TreeBuilder
  attr_reader :last_event_end_line

  def event_location(start_line, start_column, end_line, end_column)
    @last_event_end_line = end_line
    super
  end
end

def check_file(path)
  lines = File.readlines(path, chomp: true)
  return Failure.new(path, 1, "Frontmatter must start with '#{DELIMITER}' on line 1.") unless lines.first == DELIMITER

  closing_index = lines.drop(1).index(DELIMITER)
  return Failure.new(path, 1, "Frontmatter has no closing '#{DELIMITER}' line.") if closing_index.nil?

  frontmatter = lines[1, closing_index].join("\n")
  check_frontmatter(path, frontmatter)
end

# Line numbers in the returned failure count from the top of the file, which
# has the opening delimiter on line 1.
def check_frontmatter(path, frontmatter)
  builder = LocationTrackingBuilder.new
  Psych::Parser.new(builder).parse(frontmatter)
  root = builder.root.children.first&.root
  return nil if root.is_a?(Psych::Nodes::Mapping)

  Failure.new(path, 1, "Frontmatter must be a YAML map, got #{describe_node(root)}.")
rescue Psych::SyntaxError => error
  frontmatter_line = [error.line, (builder.last_event_end_line || 0) + 1].max
  Failure.new(path, frontmatter_line + 1, "Frontmatter is not valid YAML: #{error.problem} #{error.context}".strip)
end

def describe_node(node)
  case node
  when nil then "nothing"
  when Psych::Nodes::Sequence then "a list"
  when Psych::Nodes::Scalar then "a single value"
  else "a #{node.class.name.split('::').last.downcase}"
  end
end

# See https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands#setting-an-error-message
def annotation(failure)
  file = escape_property(display_path(failure.path))
  "::error file=#{file},line=#{failure.line}::#{escape_data(failure.message)}"
end

def display_path(path)
  Pathname.new(path).relative_path_from(Pathname.pwd).to_s
end

def escape_data(text)
  text.gsub("%", "%25").gsub("\r", "%0D").gsub("\n", "%0A")
end

def escape_property(text)
  escape_data(text).gsub(":", "%3A").gsub(",", "%2C")
end

root = File.expand_path(ARGV.fetch(0, DEFAULT_ROOT))
abort "Not a folder: #{root}" unless File.directory?(root)

paths = Dir.glob("**/SKILL.md", base: root).sort.map { |relative| File.join(root, relative) }
failures = paths.filter_map { |path| check_file(path) }
failures.each { |failure| puts annotation(failure) }

puts "Checked #{paths.size} SKILL.md files, #{failures.size} failed."
exit(failures.empty? ? 0 : 1)
