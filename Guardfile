group :red_green_refactor, halt_on_fail: true do
  guard 'rspec', cmd: "bundle exec rspec" do
    watch('spec/spec_helper.rb')                        { "spec" }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }

    watch(%r{^lib/sharing_tags/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  end

  guard :teaspoon do
    # Implementation files
    watch(%r{^app/assets/javascripts/sharing_tags/(.+).js.coffee})
    watch(%r{^app/assets/javascripts/sharing_tags/share/(.+).js.coffee}) { |m| "#{m[1]}_spec" }
    watch(%r{^app/assets/javascripts/sharing_tags/share/**/(.+).js.coffee}) { |m| "#{m[1]}_spec" }

    # Specs / Helpers
    watch(%r{^spec/javascripts/sharing_tags/**/*.coffee})
  end

  guard :rubocop do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end



