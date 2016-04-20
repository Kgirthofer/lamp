#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright (C) 2016 Karl Girthofer 
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lamp::prep'
include_recipe 'lamp::httpd'
include_recipe 'lamp::mysql'
