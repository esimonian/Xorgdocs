# Class lightdm::config
class lightdm::config (
  $config            = $lightdm::_config,
  $config_file       = $lightdm::config_file,
  $config_users_file = $lightdm::config_users_file,
  $config_users      = $lightdm::config_users,
) {

  if $config != {} {
    file { 'lightdm.conf':
      ensure  => 'file',
      path    => $config_file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/lightdm.conf.erb"),
      notify  => Class['lightdm::service']
    }
    file {'/etc/pam.d/lightdm':
      ensure  => 'present',
      content => template("${module_name}/lightdm"),
    }
  }

  if $config_users != {} {
    file { 'users.conf':
      ensure  => 'file',
      path    => $config_users_file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/users.conf.erb"),
      notify  => Class['lightdm::service']
    }
  }

}
