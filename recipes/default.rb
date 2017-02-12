#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, Mischa Taylor
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package 'epel-release'

package 'nginx'

directory '/var/www/html' do
  recursive true
end

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode '0644'
end

template '/etc/nginx/nginx.conf' do
  notifies :reload, 'service[nginx]', :immediately
end

directory '/etc/nginx/sites-enabled' do
  recursive true
end

template '/etc/nginx/sites-enabled/default.conf' do
  notifies :reload, 'service[nginx]', :immediately
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
