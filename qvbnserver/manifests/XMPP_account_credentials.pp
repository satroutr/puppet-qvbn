class qvbnserver::XMPP_account_credentials inherits qvbnserver {
    exec { "XMPP_account_credentials":
        command => "qvbn-rpc -a pretty set qvbn-cmot-gateway tid xmpp.account name 0 jid operator@localhost password operator",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/",
      }
}