set $frontend_upstream host.docker.internal:3456;
proxy_pass http://$frontend_upstream;
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection 'upgrade';
proxy_set_header Host $host;
proxy_cache_bypass $http_upgrade;
sub_filter '</head>' '<meta name="environment-name" content="local" /></head>';
sub_filter_once on;
