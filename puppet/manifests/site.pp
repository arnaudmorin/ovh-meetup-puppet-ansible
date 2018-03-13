node /^jump/ {
  notify { 'salut': }
}

node /^webserver/ {
  notify { 'salut': }

  package {[
    'python-flask',
    'git',
  ]:
    ensure => installed,
  }

  exec { 'clone application':
    command => '/usr/bin/git clone https://github.com/arnaudmorin/demo-flask.git /opt/demo-flask',
    creates => '/opt/demo-flask',
    require => Package['git'],
  }

  exec { '/opt/demo-flask/start.py &':
    unless    => '/bin/pidof -x start.py',
    require   => [Package['python-flask'], Exec['clone application']],
  }
}
