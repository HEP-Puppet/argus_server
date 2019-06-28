class argus_server::bdii(
  $site_name              = $argus_server::site_name,
  $bdii_config_dir        = $argus_server::bdii_config_dir
) {

  # ARGUS configuration files
  
   file { '/var/lib/bdii/gip/provider/glite-info-glue2-provider-service-argus':
    ensure  => 'present',
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0655',
    content => template("${module_name}/glite-info-glue2-provider-service-argus.erb"),
    require => Package['glite-info-provider-service'],
    notify  => Service['bdii'],
  }
  
  service { 'bdii':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['bdii'],
  }

  
  file {"${bdii_config_dir}/glite-info-glue2-argus-pap.conf":
     ensure  => 'link',
     target  => "${bdii_config_dir}/glite-info-glue2-argus-pap.conf.template",
     require => Package['glite-info-provider-service'],
     }
   
  file {"${bdii_config_dir}/glite-info-glue2-argus-pdp.conf":
     ensure  => 'link',
     target  => "${bdii_config_dir}/glite-info-glue2-argus-pdp.conf.template",
     require => Package['glite-info-provider-service'],
     }
 
  file {"${bdii_config_dir}/glite-info-glue2-argus-pep.conf":
     ensure  => 'link',
     target  => "${bdii_config_dir}/glite-info-glue2-argus-pep.conf.template",
     require => Package['glite-info-provider-service'],
     }

  file {"${bdii_config_dir}/glite-info-glue2-service-argus.conf":
     ensure  => 'link',
     target  => "${bdii_config_dir}/glite-info-glue2-service-argus.conf.template",
     require => Package['glite-info-provider-service'],
     }


}
