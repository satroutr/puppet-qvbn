class qvbnserver::download_vcpe  inherits qvbnserver {
exec { "download_vcpe":
        command => "qvbn-vcpe-download",
      path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
}
