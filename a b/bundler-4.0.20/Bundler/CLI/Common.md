# module Bundler::CLI::Common
Defined in: `lib/bundler/cli/common.rb`

## Class methods

### .ask_for_spec_from(specs)

### .clean_after_install?

Returns: `Boolean`

### .configure_gem_version_promoter(definition, options)

Raises: `InvalidOption`

### .default_gem_spec(name)

### .ensure_all_gems_in_lockfile!(names, locked_gems = Bundler.locked_gems)

### .gem_not_found_message(missing_gem_name, alternatives)

### .output_cooldown_skipped_summary(definition = Bundler.definition)

### .output_fund_metadata_summary

### .output_post_install_messages(messages)

### .output_without_groups_message(command)

### .patch_level_options(options)

### .print_post_install_message(name, msg)

### .select_spec(name, regex_match = nil)

### .validate_cooldown!(value)

Raises: `InvalidOption`

### .verbalize_groups(groups)

### .without_groups_message(command)

### .word_list(words)
