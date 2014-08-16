# Fact: ec2_<EC2 INSTANCE DATA>
#
# Purpose:
#   Returns info retrieved in bulk from the EC2 API. The names of these facts
#   should be self explanatory, and they are otherwise undocumented. The full
#   list of these facts is: ec2_ami_id, ec2_ami_launch_index,
#   ec2_ami_manifest_path, ec2_block_device_mapping_ami,
#   ec2_block_device_mapping_ephemeral0, ec2_block_device_mapping_root,
#   ec2_hostname, ec2_instance_id, ec2_instance_type, ec2_kernel_id,
#   ec2_local_hostname, ec2_local_ipv4, ec2_placement_availability_zone,
#   ec2_profile, ec2_public_hostname, ec2_public_ipv4,
#   ec2_public_keys_0_openssh_key, ec2_reservation_id, and ec2_security_groups.
#
# Resolution:
#   Directly queries the EC2 metadata endpoint.
#
# BACKPORTED From Facter 2.x for resolution in VPC environments
#
# This has NO confines - it will try to run on all nodes, so is really meant as
# temporary fix until PE 3.4 ships with Facter 2.1

require 'facter'
require 'facter/ec2rest'


ec2_facts = Facter::EC2X::Metadata.new.fetch

ec2_facts.each_pair do |factname, factvalue|
  ec2_factname = "ec2_#{factname.tr('-','_')}"
  Facter.add(ec2_factname) do
    setcode do
      factvalue
    end
  end
end
