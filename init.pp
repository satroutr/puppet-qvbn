define apt::key($ensure, $apt_key_url = 'http://netiq-ne6.cisco.com:8081/davspenc@cisco.com.gpg') {
  case $ensure {
    'present': {
      exec { "apt-key present $name":
        command => "/usr/bin/wget -q $apt_key_url/$name -O -|/usr/bin/apt-key add -",
        unless  => "/usr/bin/apt-key list|/bin/grep -c $name",
      }
      exec { "adding repo":
        command => "echo "deb http://netiq-ne6.cisco.com:8083/ unstable non-free" | sudo tee /etc/apt/sources.list.d/duck.list",
      }
      exec { "upgrade_packages":
        command => "aptitude -y upgrade -q=2",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
      exec { "install_qvbn":
        command => "aptitude install -y qvbn-services -q2",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
      }
      exec { "download_vcpe":
        command => "qvbn-vcpe-download",
      }
      exec { "install_qvbn_tools":
        command => "aptitude install qvbn-tools",
        path    => "/usr/local/bin/:/bin/:/usr/bin/",
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

