provider "oci" {
    tenancy_ocid = var.tenancy_ocid
    user_ocid = var.user_ocid
    fingerprint = var.fingerprint
    private_key_path = var.private_key_path
    region = var.region
    private_key_password = var.private_key_password
}

resource "oci_core_instance" "tester-instance" {
    # Required
    availability_domain = "hsRu:US-ASHBURN-AD-1"
    compartment_id = var.compartment_id
    shape = "VM.Standard.A1.Flex"
    shape_config {
        memory_in_gbs = 6
        ocpus = 1
    }
    source_details {
        source_id = "ocid1.image.oc1.iad.aaaaaaaamo3amvibu2izgrng5zs4u34yw5y2g2v3v5l4fxvbeezepcsren7q"
        source_type = "image"
    }

    display_name = "my-terraform-vm"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaagr22ow6lmuhhstmus6rmfhmtooc7ltqintqsuz4wsxiras32b7ra"
    }
    preserve_boot_volume = false
}

# Output the result
output "show-shape" {
    value = resource.oci_core_instance.tester-instance.shape
}