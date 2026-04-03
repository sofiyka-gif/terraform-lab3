#!/bin/bash

# Логування
exec > >(tee -a /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "[INFO] Початок виконання user_data скрипта - $(date)"

# 1. Ідемпотентне встановлення Apache2
if ! command -v apache2 &> /dev/null; then
  echo "[INFO] Встановлення Apache2..."
  apt-get update -y
  apt-get install -y apache2
else
  echo "[INFO] Apache2 вже встановлений"
fi

# 2. Зміна порту
echo "[INFO] Зміна порту на ${WEB_PORT}..."
sed -i "s/Listen 80/Listen ${WEB_PORT}/" /etc/apache2/ports.conf

# 3. DocumentRoot
echo "[INFO] Створення директорії ${DOC_ROOT}..."
mkdir -p ${DOC_ROOT}

cat <<EOF > ${DOC_ROOT}/index.html
<!DOCTYPE html>
<html>
<head>
<title>Lab 3 Terraform</title>
</head>
<body>
<h1>Все працює 🎉</h1>
<p>Студент: ${STUDENT}</p>
<p>Server: ${SERVER_NAME}</p>
<p>Port: ${WEB_PORT}</p>
</body>
</html>
EOF

chown -R www-data:www-data ${DOC_ROOT}
chmod -R 755 ${DOC_ROOT}

# 4. VirtualHost
VHOST_CONF="/etc/apache2/sites-available/custom-site.conf"

cat <<EOF > $VHOST_CONF
<VirtualHost *:${WEB_PORT}>
ServerName ${SERVER_NAME}
DocumentRoot ${DOC_ROOT}
</VirtualHost>
EOF

# 5. Доступ до папки (fix 403)
if ! grep -q "<Directory ${DOC_ROOT}>" /etc/apache2/apache2.conf; then
cat <<EOF >> /etc/apache2/apache2.conf
<Directory ${DOC_ROOT}>
Require all granted
</Directory>
EOF
fi

# 6. Перезапуск Apache
a2dissite 000-default.conf
a2ensite custom-site.conf
systemctl restart apache2
systemctl enable apache2

echo "[INFO] Завершено - $(date)"
