# Use a imagem base Debian
FROM debian:latest

# Atualize os pacotes e instale o Nginx
RUN apt-get update
RUN apt-get install -y bash vim man
    #systemctl# TODO remove
RUN apt-get install -y nginx rsync curl certbot cron
RUN mkdir -p /srv/repo/archlinux
RUN mkdir -p /var/lock
COPY syncrepo-template /usr/bin/
RUN chmod +x /usr/bin/syncrepo-template
ENV CRON_SYNCREPO "* * * * *"
ENV SOURCE_URL https://archlinux.c3sl.ufpr.br
# (Opcional) Se precisar de alguma configuração personalizada para o Nginx, adicione os arquivos de configuração aqui
# COPY nginx.conf /etc/nginx/nginx.conf

# Exponha a porta padrão do Nginx (80)
EXPOSE 80
#EXPOSE 873
# Comando para iniciar o Nginx em primeiro plano (foreground)
CMD ["service","nginx","start"]
CMD ["nginx", "-g", "daemon off;"]
#CMD sh -c "echo \"$CRON_SYNCREPO  root echo teste >> /etc/var/test.log\" >> /etc/crontab"
