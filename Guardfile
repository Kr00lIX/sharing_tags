guard 'rspec', cmd: "bundle exec rspec" do

  watch('spec/spec_helper.rb')                        { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }

end

guard :teaspoon do
  # Implementation files
  watch(%r{^app/assets/javascripts/sharing_tags/(.+).coffee}) { |m| "#{m[1]}_spec" }

  # Specs / Helpers
  watch(%r{^spec/javascripts/**/(.*)})
end
