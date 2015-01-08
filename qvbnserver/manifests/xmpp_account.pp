class qvbnserver::xmpp_account inherits qvbnserver {
    exec { "xmpp_account":
        command => "qvbn-rpc -a pretty walk qvbn-cmot-gateway tid xmpp.account",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/",
      }
}
