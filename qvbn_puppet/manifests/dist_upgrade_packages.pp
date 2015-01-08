class qvbnserver::dist_upgrade_packages inherits qvbnserver {
    exec { "dist-upgrade_packages":
        command => "aptitude -y dist-upgrade",
        path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      }
}
