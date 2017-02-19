apt_key_name = '2C52709D'
apt_key_keys = '58118E89F3A912897C070ADBF76221572C52609D'
apt_key_server = 'hkp://p80.pool.sks-keyservers.net:80'
execute "apt-key #{apt_key_name}" do
  command "apt-key adv --keyserver #{apt_key_server} --recv-keys #{apt_key_keys}"
  not_if "apt-key list | grep -q '\#{name} '"
end

file '/etc/apt/sources.list.d/docker-engine.list' do
  owner 'root'
  group 'root'
  mode '644'
  content 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  notifies :run, 'execute[apt-get update]'
end

execute 'apt-get update' do
  action :nothing
end

execute 'apt-cache policy docker-engine' do
  command 'apt-cache policy docker-engine'
end

package 'docker-engine' do
  action :install
end
