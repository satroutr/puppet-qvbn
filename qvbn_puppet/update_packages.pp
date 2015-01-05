class qvbnserver::update_packages inherits qvbnserver {
  exec { "update_packages":
        command => "aptitude -y update",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
}
