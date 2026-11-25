# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "rbconfig"

class CheckSkillFrontmatterTest < Minitest::Test
  REPO_ROOT = File.expand_path("../..", __dir__)
  SCRIPT = "scripts/check-skill-frontmatter.rb"
  FIXTURES = "scripts/test/fixtures"

  Result = Struct.new(:annotations, :exit_code)

  def check(fixture)
    output, status = Open3.capture2e(RbConfig.ruby, SCRIPT, File.join(FIXTURES, fixture), chdir: REPO_ROOT)
    Result.new(output.lines(chomp: true).grep(/\A::error /), status.exitstatus)
  end

  def test_given_valid_claude_code_fields_when_checked_then_it_passes
    result = check("valid")

    assert_equal Result.new([], 0), result
  end

  def test_given_a_date_value_when_checked_then_it_passes
    result = check("date-value")

    assert_equal Result.new([], 0), result
  end

  def test_given_no_opening_delimiter_when_checked_then_it_fails_on_line_1
    result = check("no-opening")

    expected = "::error file=#{FIXTURES}/no-opening/demo/SKILL.md,line=1::Frontmatter must start with '---' on line 1."
    assert_equal Result.new([expected], 1), result
  end

  def test_given_no_closing_delimiter_when_checked_then_it_fails_on_line_1
    result = check("no-closing")

    expected = "::error file=#{FIXTURES}/no-closing/demo/SKILL.md,line=1::Frontmatter has no closing '---' line."
    assert_equal Result.new([expected], 1), result
  end

  def test_given_unquoted_brackets_when_checked_then_it_fails_on_their_file_line
    result = check("invalid-yaml")

    expected = "::error file=#{FIXTURES}/invalid-yaml/demo/SKILL.md,line=9::" \
               "Frontmatter is not valid YAML: did not find expected key while parsing a block mapping"
    assert_equal Result.new([expected], 1), result
  end

  def test_given_empty_frontmatter_when_checked_then_it_fails_as_not_a_map
    result = check("empty-frontmatter")

    expected = "::error file=#{FIXTURES}/empty-frontmatter/demo/SKILL.md,line=1::Frontmatter must be a YAML map, got nothing."
    assert_equal Result.new([expected], 1), result
  end

  def test_given_string_frontmatter_when_checked_then_it_fails_as_not_a_map
    result = check("string-frontmatter")

    expected = "::error file=#{FIXTURES}/string-frontmatter/demo/SKILL.md,line=1::" \
               "Frontmatter must be a YAML map, got a single value."
    assert_equal Result.new([expected], 1), result
  end

  def test_given_list_frontmatter_when_checked_then_it_fails_as_not_a_map
    result = check("list-frontmatter")

    expected = "::error file=#{FIXTURES}/list-frontmatter/demo/SKILL.md,line=1::Frontmatter must be a YAML map, got a list."
    assert_equal Result.new([expected], 1), result
  end

  def test_given_two_broken_files_when_checked_then_it_reports_both
    result = check("two-broken")

    expected = [
      "::error file=#{FIXTURES}/two-broken/first/SKILL.md,line=1::Frontmatter must start with '---' on line 1.",
      "::error file=#{FIXTURES}/two-broken/second/SKILL.md,line=9::" \
      "Frontmatter is not valid YAML: did not find expected key while parsing a block mapping"
    ]
    assert_equal Result.new(expected, 1), result
  end
end
