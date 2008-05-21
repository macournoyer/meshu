namespace :nginx do
  task :start do
    sh "sudo /usr/local/nginx/sbin/nginx -c config/nginx.conf"
  end

  task :stop do
    sh "sudo kill -INT `cat /usr/local/nginx/logs/nginx.pid`"
  end

  task :restart do
    sh "sudo kill -HUP `cat /usr/local/nginx/logs/nginx.pid`"
  end
end