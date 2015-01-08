class qvbnserver::adding_repo inherits qvbnserver {
$apt_key_url = 'http://netiq-ne6.cisco.com:8081/davspenc@cisco.com.gpg'
      exec { "apt-key present $name":
        command => "wget -q $apt_key_url -O -| apt-key add -",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
      exec { "adding repo":
        command => "echo 'deb http://netiq-ne6.cisco.com:8083/ unstable non-free' >> /etc/apt/sources.list.d/duck.list",
        path => "/bin/",
      }
}
