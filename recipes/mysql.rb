sql_password = Chef::EncryptedDataBagItem.load('mysql', 'password')

service 'mysqld' do
  action [:start,:enable]
  only_if { node['lamp']['mysql']['install_sql'] }
end

bash 'mysql-install' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \\"Enter current password for root (enter for none):\\"
    send \\"\r\\"
    expect \\"Change the root password?\\"
    send \\"y\r\\"
    expect \\"New password:\\"
    send \\"#{sql_password['mysql_password']}\r\\"
    expect \\"Re-enter new password:\\"
    send \\"#{sql_password['mysql_password']}\r\\"
    expect \\"Remove anonymous users?\\"
    send \\"y\r\\"
    expect \\"Disallow root login remotely?\\"
    send \\"y\r\\"
    expect \\"Remove test database and access to it?\\"
    send \\"y\r\\"
    expect \\"Reload privilege tables now?\\"
    send \\"y\r\\"
    expect eof"
  EOH
  only_if { node['lamp']['mysql']['install_sql'] }
end

ruby_block 'set install_sql' do
  block do
    node.set['lamp']['mysql']['install_sql'] = false
    node.save
  end
  action :run
end
