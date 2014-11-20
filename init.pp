define apt::key($ensure, $apt_key_url = 'http://netiq-ne6.cisco.com:8081/davspenc@cisco.com.gpg') {
  case $ensure {
    'present': {
      exec { "apt-key present $name":
        command => "/usr/bin/wget -q $apt_key_url/$name -O -|/usr/bin/apt-key add -",
        unless  => "/usr/bin/apt-key list|/bin/grep -c $name",
      }
      exec { "adding repo":
        command => "echo 'deb http://netiq-ne6.cisco.com:8083/ unstable non-free' | sudo tee /etc/apt/sources.list.d/duck.list",
      }
      exec { "update_packages":
        command => "aptitude -y update -q=2",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
      exec { "dist-upgrade_packages":
        command => "aptitude -y dist-upgrade -q=2",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
      package { "qvbn-services":
        ensure => "installed",
      }
      exec { "download_vcpe":
        command => "qvbn-vcpe-download",
      }
      package { "qvbn-tools":
        ensure => "installed",
      }
    }
    'absent': {
      exec { "apt-key absent $name":
        command => "/usr/bin/apt-key del $name",
        onlyif  => "/usr/bin/apt-key list|/bin/grep -c $name",
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for apt::key"
    }
  }
}

