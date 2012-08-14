# Guardfile for running minitest specs.

guard 'minitest' do
  # with Minitest::Spec
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^lib/(.*)/([^/]+)\.rb|)    { |m| "spec/#{m[2]}_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)    { 'spec' }

end
