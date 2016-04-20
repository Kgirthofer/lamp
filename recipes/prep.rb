%w(
  httpd24
  php56
  mysql55-server
  php56-mysqlnd
  expect
).each do |pkg|
  package pkg do
    action :install
  end
end

group 'www' do
  action :create
end
