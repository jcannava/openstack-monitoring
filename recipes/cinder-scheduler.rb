# Cookbook Name:: openstack-monitoring
# Recipe:: cinder-scheduler
#
# Copyright 2013, Rackspace US, Inc.
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
include_recipe "monitoring"

if node.recipe?("cinder::cinder-scheduler")
    platform_options = node["cinder"]["platform"]
    monitoring_procmon "cinder-scheduler" do
        service_name=platform_options["cinder_scheduler_service"]
        process_name "cinder-scheduler"
        script_name service_name
    end

    monitoring_metric "cinder-scheduler-proc" do
        type "proc"
        proc_name "cinder-scheduler"
        proc_regex platform_options["cinder_scheduler_service"]
        alarms(:failure_min => 2.0)
    end
end
