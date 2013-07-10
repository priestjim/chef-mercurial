#
# Cookbook Name:: mercurial
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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
#

if node['mercurial']['use_ppa'] && platform?('ubuntu')

  include_recipe 'apt'

  apt_repository 'mercurial' do
    uri node['mercurial']['ppa_url']
    distribution node['lsb']['codename']
    components ['main']
    deb_src false
    cache_rebuild true
    keyserver 'keyserver.ubuntu.com'
    key '323293EE'
    action :nothing
    notifies :run, 'execute[apt-get update mercurial]', :immediately
  end

  execute 'apt-get update mercurial' do
    command 'apt-get update'
    action :nothing
  end


end

package 'mercurial' do
  action :upgrade
end
