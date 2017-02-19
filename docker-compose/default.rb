os = 'Linux'
arch = 'X86_64'
version = '1.11.1'
url = "https://github.com/docker/compose/releases/download/#{version}/docker-compose-#{os}-#{arch}"
command_path = '/usr/local/bin/docker-compose'

execute 'install docker compose' do
  command "curl -L #{url} -o #{command_path}"
  not_if "test -e #{command_path}"
end

file command_path do
  action :edit
  mode '755'
end
