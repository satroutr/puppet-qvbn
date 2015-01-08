class qvbnserver::delete_packages inherits qvbnserver {
    exec { "delete_packages":
        command => "aptitude clean",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
}

