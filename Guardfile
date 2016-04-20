# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'foodcritic', cookbook_paths: '.', notification: false, cli: '-X spec/' do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
  watch(%r{libraries/.+\.rb$})
end

seed = ENV['SEED'].nil? ? '' : " --seed #{ENV['SEED']}"
guard :rspec, cmd: "chef exec rspec#{seed}", all_on_start: false, notification: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')     { 'spec' }
  watch(%r{^attributes/(.+)\.rb$}) { |m| "spec/attributes/#{m[1]}_spec.rb" }
  watch(%r{^libraries/(.+)\.rb$})  { |m| "spec/libraries/#{m[1]}_spec.rb" }
  watch(%r{^providers/(.+)\.rb$})  { |m| "spec/providers/#{m[1]}_spec.rb" }
  watch(%r{^recipes/(.+)\.rb$})    { |m| "spec/recipes/#{m[1]}_spec.rb" }
  watch(%r{^resources/(.+)\.rb$})  { |m| "spec/resources/#{m[1]}_spec.rb" }
  watch(%r{^templates/(.+)\.rb$})  { |m| "spec/templates/#{m[1]}_spec.rb" }

  ignore(%r{^spec/integration/(.+)\.rb$})
end

# #guard 'kitchen' do
##  watch(%r{^test/integration/default/serverspec/localhost/(.+)_spec.rb})
##  watch(%r{^recipes/(.+)\.rb$})
##  watch(%r{^attributes/(.+)\.rb$})
##  watch(%r{^files/(.+)})
##  watch(%r{^templates/(.+)})
##  watch(%r{^providers/(.+)\.rb})
##  watch(%r{^resources/(.+)\.rb})
## end
